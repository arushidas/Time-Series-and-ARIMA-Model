# Time-Series-and-ARIMA-Model
Time Series and ARIMA Model on Covid-19 Data in Canada


### Introduction:
This project focuses on analyzing the evolution of the COVID-19 pandemic in Canada. The project aims to examine the trend of new COVID-19 cases, its impact on deaths and mortality rates, and the adaptation of Canada's healthcare system to the pandemic. The research also explores the differences in death rates between Canada and other countries. The dataset used is sourced from Our World in Data, containing various metrics related to COVID-19 in Canada.


### Dataset: [CSV](https://covid.ourworldindata.org/data/owid-covid-data.csv) | [XLSX](https://covid.ourworldindata.org/data/owid-covid-data.xlsx) | [JSON](https://covid.ourworldindata.org/data/owid-covid-data.json)
The COVID-19 dataset used in the project is a subset of Our World in Data's compilation of COVID-19 data specific to Canada. The dataset includes metrics such as cases, deaths, hospital and ICU patients, tests, positive rates, vaccinations, and policy responses. The data sources vary, including John Hopkins University, official sources, the OWID team, and other organizations like UN and World Bank.


### Methodology:
The project begins by loading the necessary libraries and the COVID-19 dataset from Our World in Data's GitHub Repository. The data is then cleaned, filtering out unwanted columns and narrowing the research focus to Canada. Visualizations are created, plotting new daily cases and deaths over time. Time-series analysis is performed using univariate and multivariate approaches, examining various metrics such as ICU patients, hospital patients, stringency index, and excess mortality. Finally, forecasting is conducted using the ARIMA model to predict new daily COVID-19 cases for the next six months.


### Research Gaps:
The project identifies several research gaps for further exploration. These include transforming the COVID-19 data into a normal distribution and applying regression algorithms, RNN, or LSTM models. Additionally, the study suggests investigating the correlation between daily new cases and deaths and exploring more proactive measures to prevent major peaks in COVID-19 cases.


### Conclusion:
The project concludes that Canada employed various community health strategies, such as hand sanitation, self-isolation, social distancing, and lockdowns, to combat the public health risks posed by COVID-19. The analysis indicates that the peak of COVID-19 in Canada is expected to decrease in the next six months(as on April 2022) based on time-series analysis. The study also highlights the correlation between daily new cases and deaths, as well as the burden on healthcare systems and increased mortality rates during the first and second waves of the pandemic. The conclusion emphasizes the need for more foresight and novel frameworks in strategic planning and policy-making to prevent major peaks in COVID-19 cases.

*Keywords: COVID-19, Canada, Pandemic, Time series analysis, ARIMA, Forecasting*
