var lineChartData = {
			labels: labels,
			datasets: [{
				label: '주문량',
				borderColor: "rgba(28, 200, 138, 1)", //선
				backgroundColor:"rgba(28, 200, 138, 1)", //점  //파랑
				fill: false,
				data: data,
				yAxisID: 'y-axis-1',
			 
			} ]
		};
var totalPrice = {
			labels: totalPriceLabels,
			datasets: [{
				label: '월매출',
				borderColor: "rgba(28, 200, 138, 1)", //선
				backgroundColor:"rgba(28, 200, 138, 1)", //점  //파랑
				fill: false,
				data: totalPriceData,
				yAxisID: 'y-axis-1',
			 
			} ]
		};
 

var client = {
			labels: clientChartLabels,
			datasets: [{
				label: '회원수' , 
				borderColor: "rgba(28, 200, 138, 1)", //선
				backgroundColor:"rgba(28, 200, 138, 1)", //점  //파랑
				fill: false,
				data: clientChartDate,
				yAxisID: 'y-axis-1',
			 
			}, {
				label: '회원 탈퇴수',
				borderColor: "rgba(128, 38, 151, 1)",
				backgroundColor: "rgba(128, 38, 151, 1)",
				fill: false,
				data: clientChartDateD,
				yAxisID: 'y-axis-1'
			}]
		};
var vendor = {
			labels: vendorChartLabels,
			datasets: [{
				label: '업체수',
				borderColor: "rgba(28, 200, 138, 1)", //선
				backgroundColor:"rgba(28, 200, 138, 1)", //점  //파랑
				fill: false,
				data: vendorChartDate,
				yAxisID: 'y-axis-1',
			 
			}, {
				label: '업체 탈퇴수',
				borderColor: "rgba(128, 38, 151, 1)",
				backgroundColor: "rgba(128, 38, 151, 1)",
				fill: false,
				data:  vendorChartDateD,
				yAxisID: 'y-axis-1'
			}]
		};
		

		window.onload = function() {
			var ctx = document.getElementById('canvas').getContext('2d');
			
			window.myLine = Chart.Line(ctx, {
				data: lineChartData,
				options: {
					responsive: true,
					hoverMode: 'index',
					stacked: false,
					title: {
						display: true,
						text: ''
					},
					scales: {
						yAxes: [{
							type: 'linear',
							display: true,
							position: 'left',
							id: 'y-axis-1',
						}, {
							type: 'linear',  
							display: true,
							position: 'right',
							id: 'y-axis-1',

							// grid line settings
							gridLines: {
								drawOnChartArea: false,  
							},
						}],
					}
				}
			});
		
		var ctx = document.getElementById('totalPrice').getContext('2d');
			
			window.myLine = Chart.Line(ctx, {
				data: totalPrice,
				options: {
					responsive: true,
					hoverMode: 'index',
					stacked: false,
					title: {
						display: true,
						text: ''
					},
					scales: {
						yAxes: [{
							type: 'linear',
							display: true,
							position: 'left',
							id: 'y-axis-1',
						}, {
							type: 'linear',  
							display: true,
							position: 'right',
							id: 'y-axis-1',

							// grid line settings
							gridLines: {
								drawOnChartArea: false,  
							},
						}],
					}
				}
			});
			 
			 
			
			var ctx = document.getElementById('clientChart').getContext('2d');
			
			window.myLine = Chart.Line(ctx, {
				data: client,
				options: {
					responsive: true,
					hoverMode: 'index',
					stacked: false,
					title: {
						display: true,
						text: ''
					},
					scales: {
						yAxes: [{
							type: 'linear',
							display: true,
							position: 'left',
							id: 'y-axis-1',
						}, {
							type: 'linear',  
							display: true,
							position: 'right',
							id: 'y-axis-1',

							// grid line settings
							gridLines: {
								drawOnChartArea: false,  
							},
						}],
					}
				}
			});
	var ctx = document.getElementById('vendorChart').getContext('2d');
			
			window.myLine = Chart.Line(ctx, {
				data: vendor,
				options: {
					responsive: true,
					hoverMode: 'index',
					stacked: false,
					title: {
						display: true,
						text: ''
					},
					scales: {
						yAxes: [{
							type: 'linear',
							display: true,
							position: 'left',
							id: 'y-axis-1',
						}, {
							type: 'linear',  
							display: true,
							position: 'right',
							id: 'y-axis-1',

							// grid line settings
							gridLines: {
								drawOnChartArea: false,  
							},
						}],
					}
				}
			});
			
			
		};

	