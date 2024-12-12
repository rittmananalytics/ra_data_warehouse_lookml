looker.plugins.visualizations.add({
    id: "highcharts_violin_plot",
    label: "Violin Plot",
    options: {
      step: {
        type: "number",
        label: "Step Size",
        default: 0.1
      },
      precision: {
        type: "number",
        label: "Precision",
        default: 0.001
      },
      densityWidth: {
        type: "number",
        label: "Density Width",
        default: 0.5
      }
    },
    create: function(element, config) {
      this.container = element.appendChild(document.createElement("div"));
      this.container.id = "highcharts-container";
    },
    updateAsync: function(data, element, config, queryResponse, details, done) {
      console.log("updateAsync called");
      console.log("Data received:", data);
      console.log("Query response:", queryResponse);
  
      this.clearErrors();
  
      if (!queryResponse || !data || data.length === 0) {
        console.log("No data available");
        this.addError({ title: "No Data", message: "This chart requires data to render." });
        done();
        return;
      }
  
      console.log("Data and query response are valid");
  
      // Check if we have the necessary fields
      if (!queryResponse.fields.dimensions || queryResponse.fields.dimensions.length < 2) {
        console.log("Not enough dimensions found");
        this.addError({ title: "Insufficient Dimensions", message: "This chart requires two dimensions: one for categories and one for values." });
        done();
        return;
      }
  
      let processedData = [];
      let categories = [];
  
      // Assuming the first dimension is used for categories and the second for values
      let dimensionName = queryResponse.fields.dimensions[0].name;
      let measureName = queryResponse.fields.dimensions[1].name;
      console.log("Dimension name:", dimensionName);
      console.log("Measure name:", measureName);
  
      // Group data by category
      let groupedData = {};
      data.forEach((row, index) => {
        console.log(`Processing row ${index}:`, row);
        let category = LookerCharts.Utils.textForCell(row[dimensionName]);
        let value = LookerCharts.Utils.textForCell(row[measureName]);
        console.log(`Category: ${category}, Value: ${value}`);
  
        if (!groupedData[category]) {
          groupedData[category] = [];
        }
        groupedData[category].push(Number(value));
      });
  
      console.log("Grouped data:", groupedData);
  
      // Process grouped data
      for (let category in groupedData) {
        categories.push(category);
        processedData.push(groupedData[category]);
      }
  
      console.log("Processed data:", processedData);
      console.log("Categories:", categories);
  
      let step = config.step || 0.1;
      let precision = config.precision || 0.001;
      let densityWidth = config.densityWidth || 0.5;
      console.log("Config values:", { step, precision, densityWidth });
  
      console.log("Calling processViolin function");
      let violinData = processViolin(step, precision, densityWidth, ...processedData);
      console.log("Violin data:", violinData);
  
      let seriesData = violinData.results.map((result, index) => ({
        name: categories[index],
        data: result.filter(point => point[1] !== null && point[2] !== null)
      }));
      console.log("Series data:", seriesData);
  
      console.log("Creating Highcharts visualization");
  Highcharts.chart(element, {
    chart: {
      type: 'areasplinerange',
      inverted: true
    },
    title: {
      text: null  // This removes the title
    },
    xAxis: {
      reversed: false,
      labels: { format: '{value}' }  // You can adjust this if you need a specific unit
    },
    yAxis: {
      title: { text: null },
      categories: categories,  // This will use your categories
      startOnTick: false,
      endOnTick: false,
      gridLineWidth: 0
    },
    tooltip: {
      useHTML: true,
      valueDecimals: 3,
      formatter: function () {
        return `<b>${this.series.name}</b><table>
          <tr><td>Max:</td><td>${violinData.stat[this.series.index][4]}</td></tr>
          <tr><td>Q3:</td><td>${violinData.stat[this.series.index][3]}</td></tr>
          <tr><td>Median:</td><td>${violinData.stat[this.series.index][2]}</td></tr>
          <tr><td>Q1:</td><td>${violinData.stat[this.series.index][1]}</td></tr>
          <tr><td>Min:</td><td>${violinData.stat[this.series.index][0]}</td></tr>
        </table>`;
      }
    },
    plotOptions: {
      series: {
        marker: {
          enabled: false
        },
        states: {
          hover: {
            enabled: false
          }
        },
        events: {
          legendItemClick: function (e) {
            e.preventDefault();
          }
        },
        pointStart: violinData.xiData[0]
      }
    },
    series: seriesData.map((series, index) => ({
      name: series.name,
      color: Highcharts.getOptions().colors[index],  // This uses Highcharts default colors
      data: series.data
    }))
  });
  
      console.log("Highcharts visualization created");
      done();
    }
  });
  
  function processViolin(step, precision, densityWidth, ...args) {
    let xiData = [];
    function processXi(args) {
      let tempXdata = [];
      let tileSteps = 6;
      let min = Infinity,
        max = -Infinity;
      args.forEach((e) => {
        min = Math.min(min, Math.min(...e));
        max = Math.max(max, Math.max(...e));
      });
      for (let i = min - tileSteps * step; i < max + tileSteps * step; i += step) {
        tempXdata.push(i);
      }
      return tempXdata;
    }
    xiData = processXi(args);
    function kdeProcess(xi, u) {
      return (1 / Math.sqrt(2 * Math.PI)) * Math.exp(Math.pow(xi - u, 2) / -2);
    }
    let gap = -1;
    function violinProcess(dataSource) {
      let data = [];
      let N = dataSource.length;
      gap++;
      for (let i = 0; i < xiData.length; i++) {
        let temp = 0;
        for (let j = 0; j < dataSource.length; j++) {
          temp = temp + kdeProcess(xiData[i], dataSource[j]);
        }
        data.push([xiData[i], (1 / N) * temp]);
      }
      return data.map((violinPoint) => {
        if (violinPoint[1] > precision) {
          return [violinPoint[0], -(violinPoint[1] * densityWidth) + gap, (violinPoint[1] * densityWidth) + gap];
        } else {
          return [violinPoint[0], null, null];
        }
      });
    }
    let results = [];
    let stat = [];
    let index = 0;
    args.forEach((e) => {
      results.push([]);
      stat.push([]);
      results[index] = violinProcess(e).slice();
      stat[index].push(
        Math.min(...e),
        jStat.quartiles(e)[0],
        jStat.quartiles(e)[1],
        jStat.quartiles(e)[2],
        Math.max(...e)
      );
      index++;
    });
    return { xiData, results, stat };
  }
  