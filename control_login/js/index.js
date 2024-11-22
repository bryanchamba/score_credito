document.addEventListener('DOMContentLoaded', function () {
    const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 4000,
        timerProgressBar: true,
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer)
            toast.addEventListener('mouseleave', Swal.resumeTimer)
        }
    });
    let form = document.getElementById('fmr');
    form.elements.npt_user.focus();

    form.addEventListener('submit', (e) => onlog(e));

    function onlog(e) {
        e.preventDefault();
        let u = fmr.elements.npt_user.value;
        let p = fmr.elements.npt_pass.value;
        if (u !== '' && u.length > 2 && p !== '' && p.length > 2) {
            form.elements.btn_main.setAttribute('disabled', true);
            Toast.fire({
                icon: 'info',
                title: 'Ingresando'
            });
            setTimeout(() => {
                $.ajax({
                    data: { OPC: 'SLG', d1: u, d2: p },
                    url: urlS('index'),
                    type: 'post',
                    dataType: 'json',
                    success: function (r) {
                        if (r[0]) {
                            window.location.href = r[2];
                        } else {
                            form.elements.btn_main.removeAttribute('disabled');
                            Toast.fire({
                                icon: 'error',
                                title: r[1]
                            });
                            fmr.elements.npt_user.value = '';
                            form.elements.npt_user.focus();
                        }
                    },
                    error: function (xhr) {
                        form.elements.btn_main.removeAttribute('disabled');
                        Toast.fire({
                            icon: 'error',
                            title: '¡Ocurrio un error!'
                        });
                        console.error(xhr.responseText);
                    }
                });
            }, 600);
        } else {
            Toast.fire({
                icon: 'info',
                title: '¡Llene todos los campos requeridos (<span class="red-text">*</span>)!'
            });
            fmr.elements.npt_user.value = '';
            fmr.elements.npt_pass.value = '';
            form.elements.npt_user.focus();
        }
    }
    function drawChart() {
        document.getElementById('chart_div').innerHTML = '';
        gauge = anychart.gauges.circular();
        gauge
            .fill('#fff')
            .stroke(null)
            .padding(0)
            .margin(100)
            .startAngle(270)
            .sweepAngle(180);

        gauge
            .axis()
            .labels()
            .padding(5)
            .fontSize(14)
            .position('outside')
            .format('');//'{%Value}'

        gauge.data([0]);

        gauge
            .axis()
            .scale()
            .minimum(0)
            .maximum(100)
            .ticks({ interval: 10 })
            .minorTicks({ interval: 5 });

        gauge
            .axis()
            .fill('#545f69')
            .width(1)
            .ticks({ type: 'line', fill: 'white', length: 2 });

        gauge.title(
            `<span style="color:#009900; font-size: 14px;">(Total clientes <strong>${tot}</strong>)</span><br>
            <h2></h2>`
        );
        gauge
            .title()
            .useHtml(true)
            .padding(0)
            .fontColor('#212121')
            .hAlign('center')
            .margin([0, 0, 10, 0]);

        gauge
            .needle()
            .stroke('2 #545f69')
            .startRadius('5%')
            .endRadius('90%')
            .startWidth('0.1%')
            .endWidth('0.1%')
            .middleWidth('0.1%');

        gauge.cap().radius('3%').enabled(true).fill('#545f69');
        //---
        gauge.range(0, {
            from: 0,
            to: 30,
            position: 'inside',
            fill: '#4caf50 1',
            startSize: 50,
            endSize: 50,
            radius: 98
        });

        gauge.range(1, {
            from: 30,
            to: 70,
            position: 'inside',
            fill: '#ffeb3b 1',
            startSize: 50,
            endSize: 50,
            radius: 98
        });

        gauge.range(2, {
            from: 70,
            to: 100,
            position: 'inside',
            fill: '#f44336 1',
            startSize: 50,
            endSize: 50,
            radius: 98
        });

        gauge
            .label(1)
            .text('Bajo')
            .fontColor('#212121')
            .fontSize(14)
            .offsetY('68%')
            .offsetX(25)
            .anchor('center');

        gauge
            .label(2)
            .text('Medio')
            .fontColor('#212121')
            .fontSize(14)
            .offsetY('68%')
            .offsetX(90)
            .anchor('center');

        gauge
            .label(3)
            .text('Alto')
            .fontColor('#212121')
            .fontSize(14)
            .offsetY('68%')
            .offsetX(155)
            .anchor('center');

        gauge.container('chart_div');
        gauge.draw();
    }
    function ch_barras() {
        var data = [
            {
                x: ['ALTO', 'MEDIO', 'BAJO'],
                y: [vals.ALTO, vals.MEDIO, vals.BAJO],
                type: 'bar',
                text: [vals.ALTO, vals.MEDIO, vals.BAJO],
                marker: {
                    color: ['rgba(244,67,54,1)', 'rgba(255,235,59,1)', 'rgba(76,185,80,1)']
                }
            }
        ];

        Plotly.newPlot('myDiv01', data);
    }
    function shdGraf(e, container, data) {
        e.setAttribute('disabled', true);
        let contai = document.getElementById(container);
        if (contai.className == 'hide') {
            contai.className = '';
            document.getElementById(data[0][0]).innerHTML = '';
            document.getElementById(data[1][0]).innerHTML = '';
            document.getElementById(data[2][0]).innerHTML = '';
            ch_linear_aut(data[0][0], data[0][1]);
            ch_linear_gra(data[1][0], data[1][1]);
            ch_linear_fre(data[2][0], data[2][1]);
        } else {
            contai.className = 'hide';
        }
        e.removeAttribute('disabled');
    }
    function ch_linear_aut(container, data) {
        let chart = anychart.line3d();
        chart.animation(true);
        chart
            .title()
            .enabled(true)
            .useHtml(true)
            .text('Transacciones por mes');

        chart.yAxis().title('Valor');

        let series = chart.line();
        series.data(data);
        series.name('Valoresss');

        series.labels().enabled(true).fontColor('#212121');
        series.markers(true);
        chart
            .tooltip()
            .positionMode('point')
            .anchor('left-top')
            .offsetX(5)
            .offsetY(5);

        chart.interactivity().hoverMode('by-x');
        chart.container(container);
        chart.draw();
    }
    function ch_linear_gra(container, data) {
        let dataSet = anychart.data.set(data);

        // map data for the first series,take value from first column of data set
        let firstSeriesData = dataSet.mapAs({ x: 0, value: 1 });

        // map data for the second series,take value from second column of data set
        let secondSeriesData = dataSet.mapAs({ x: 0, value: 2 });

        // map data for the third series, take x from the zero column and value from the third column of data set
        let thirdSeriesData = dataSet.mapAs({ x: 0, value: 3 });

        let fourSeriesData = dataSet.mapAs({ x: 0, value: 4 });

        // create line chart
        let chart = anychart.line();

        // turn on chart animation
        chart.animation(true);

        // turn on the crosshair and tune it
        chart
            .crosshair()
            .enabled(true)
            .yLabel(false)
            .xLabel(false)
            .yStroke(null);

        // set chart padding
        chart.padding([10, 20, 5, 20]);

        // set chart title text settings
        chart.title('Grafica de control / Frecuencia de transacciones');

        // temp variable to store series instance
        let series;

        // setup first series
        series = chart.line(firstSeriesData);
        series.name('Limite inferior').size(4).stroke({
            color: '#d50000',
            dash: '3 5 10 5'
        });
        series.hovered().markers(true);

        // setup second series
        series = chart.line(secondSeriesData);
        series.name('Limite central').size(4).stroke({
            color: '#ffff00',
            dash: '3 5 10 5'
        });
        series.hovered().markers(true);

        // setup third series
        series = chart.line(thirdSeriesData);
        series.name('Limite superior').size(4).stroke({
            color: '#4a148c',
            dash: '3 5 10 5'
        });
        series.hovered().markers(true);

        // setup second series
        series = chart.line(fourSeriesData);
        series.name('Transacciones').size(4).stroke('#000000');
        series.labels().enabled(true).anchor('left-bottom').padding(5);
        series.hovered().markers(true);

        // interactivity and tooltip settings
        chart.interactivity().hoverMode('by-x');

        chart
            .tooltip()
            .displayMode('separated')
            .positionMode('point')
            .separator(false)
            .position('right')
            .anchor('left-bottom')
            .offsetX(2)
            .offsetY(5)
            .title(false)
            .format('{%Value}');

        // turn the legend on
        chart.legend(true);

        // set container id for the chart
        chart.container(container);
        // initiate chart drawing
        chart.draw();
    }
    function ch_linear_fre(container, data) {
        let chart = anychart.line3d();
        chart.animation(true);
        chart
            .title()
            .enabled(true)
            .useHtml(true)
            .text(
                'Grafica de control<br/>' +
                '<span style="color:#212121; font-size: 13px;">' +
                'Frecuencia de depositos' +
                '</span>'
            );

        chart.yAxis().title('Valor');

        let series = chart.line();
        series.data(data);
        series.name('Valoresss');

        series.labels().enabled(true).fontColor('#212121');
        series.markers(true);
        chart
            .tooltip()
            .positionMode('point')
            .anchor('left-top')
            .offsetX(5)
            .offsetY(5);

        chart.interactivity().hoverMode('by-x');
        chart.container(container);
        chart.draw();
    }
});