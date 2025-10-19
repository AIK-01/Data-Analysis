# Olympic Events & Performance Analysis (1996-2016)

# Table of Contents
- [Project Overview](#project-overview)
- [Analytics Tools](#analytics-tools)
- [Data Structure Overview](#data-structure-overview)
- [Summary of the Analysis](#summary-of-the-analysis)
- [Questions & Hypotheses](#questions--hypotheses)
  - [Questions](#questions)
  - [Hypotheses](#hypotheses)
- [Answering Questions](#answering-questions)
  - [Medal Points](#medal-points-explanation)
- [Testing Hypotheses](#testing-hypotheses)
- [Mixed Events](#mixed-events)
  - [Q&A](#qa)
    - [Questions](#questions-1)
    - [Answering Questions](#answering-questions-1)
- [Historical Facts](#historical-facts)	

# Project Overview

This analysis is performed on the **Olympic Sports events** and **participants** over a time span of **120 years**. This analysis can reveal the patterns and factors that influence Olympic Sports performance and participation, which can be useful for news reporters, sports enthusiasts, and anyone curious about the Olympics.

# Analytics Tools
To complete this analysis, the following tools were used:

- **MySQL (DBMS):**
Used for **data extraction**, **complex querying**, **segmentation**, and **statistical calculations** (**medal points**, **age**, **BMI**). Enabled joins between tables and prepared datasets for **gender**, **season**, and **event-based** analyses.

- **OpenRefine:**
Handled **data cleaning**, **standardization**, and **format consistency** across large datasets, ensuring uniform country codes, sport names, and categorical fields like gender and medal type.

- **Spreadsheets:**
leveraged for **summarization**, **tabulation**, and **cross-verification** of results. Also used for **KPI** documentation, **trend** aggregation, and **publishing** publicly viewable summary sheets.

- **Tableau:**
Used for creating visuals to show **seasonal participation** and **age distribution**.

# Data Structure Overview

I have been provided with **2** datasets regarding the Olympics.

These include:

- **athletes_events :** **demographic** information about individual athletes, as well as their participated **events**. Additionally, includes the **NOC** code as well as the **Medal** type of an athlete if they have won an event.
  -  Records: 271,116 

- **noc_regions :** Information about Distinct **NOC** codes and the **region/country** they represent.
  - Records: 230

<p align='center'>
<img height=450 width=700
 	src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/Olympic-ERD.png" 
	alt="Olympic-ERD" >
</p>

---

# Summary of the Analysis

- The **USA**, **Russia**, and **Germany** have the best athletes, proven by their numerous Olympic medals. It shows their serious commitment to sports performance.

- Popular sports like **athletics**, **gymnastics**, and **swimming** have too many participants, increasing competition compared to less-known sports.

- Less-known sports have fewer participants, giving countries with less focus on sports a higher chance of winning.
- Countries should train athletes in multiple sports, not just one or two, to avoid failure. The Olympics is about continuous improvement, so diversifying can help countries find sport(s) they excel.
- Many countries stop participating in the Olympics after a few attempts due to the lack of success. They should try all sports to find the sport(s) where they have a higher chance of winning medals and then train their athletes accordingly.
- While training is crucial, factors like **age**, **height**, **weight**, and **BMI** also matter in the Olympics. For example, a 10-year-old can’t outrun a 25-year-old, and an 8-foot-tall player has an advantage in basketball over a 5-foot-tall player.
- Countries without cold climates are less likely to participate in the Winter Olympics. They struggle to train athletes for cold conditions, affecting performance. Solutions are needed from both countries and the International Olympic Committee (IOC).
- The Winter Olympics have fewer sports due to less participation. It should offer as many sports as the Summer Olympics to increase interest and participation.
- Many countries don’t participate in women’s sports. The **IOC** should promote gender, cultural, and racial equality to ensure no one is left behind in the Olympics.


# Questions & Hypotheses

## Questions

**1. Which Countries have won the highest Number of Medals?**
  - **1.1.** This can provide a clear idea of countries' ranking based on their Medal winnings in various sports.
  - **1.2.** This can demonstrate which countries excel in sports.

**2. What Sports are most popular?**
  - **2.1.** In each country?
  - **2.2.** Of all time?

**3. Which country is best in which sport?**

**4. What are the beginning and ending years of participation of each country?**

**5. What is the average Age, Weight, and Height of athletes in different sports?**

**6. Is there anything hidden in the age range?**

## Hypotheses

**A. Youngsters(18-35) are more likely to win competitions than oldsters(35+).**
  - Since Younger people are likely more energetic than older people.

**B. The weight and height of the players matter together. (BMI)**
  - Overweight people are more likely to win fewer competitions.

**C. There are some specific reasons for fewer athletes participating in**
  - **Women's sports** - not all countries participate in women's sports, AND/OR women have fewer sports to participate in.
  - **Winter sports** - not all countries participate in the Winter season.

# Answering Questions

Before jumping into the actual analysis, I discovered some skewness in the data, and it can’t be fixed without splitting the data into multiple parts and analyzing each part separately. First, I’m gonna divide the dataset for two different seasons, ‘**SUMMER**’ and ‘**WINTER**’, and then I’m gonna split these two parts again into two more parts; one for '**Male**' and the other for '**Female**'.
So I have **4** new tables.

- **Summer Male**
- **Summer Female**
- **Winter Male**
- **Winter Female**  

 <br> 
  
<p align='center'>
<img height=600
 	src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/Main%20Analysis%20Participation%20Rate.png" 
	alt="Main Analysis Participation Rate" >
</p>
  
 <br>
 
Additionally, while performing **EDA**(Exploratory Data Analysis), I found that the `event` column correlates with the `sex` column. If the Event name contains the word “**Men’s**”, the `sex` column value is ‘**M**’, indicating a **Male**. Likewise, if the Event name contains the word “**Women’s**”, the `sex` column value is ‘**F**’, indicating a **Female**. But some Event names do not contain either; instead, they contain a common word ‘**Mixed**’ across the column.

This indicates that the sport is for both ‘**Male**’ & ‘**Female**’, and most of these sports have double participants where one of them is a ‘**Male**’ and the other is a ‘**Female**’. Therefore, these events can’t be considered specific to any **Sex**, nor can they be analyzed by including these records in the **4** tables I mentioned earlier, because those tables are gender specific. That's why I analyzed these Mixed events separately, and they are described at the very end of the project.
<br>
<br>
<br>
**1. Which Countries have won the highest Number of Medals?**
  - **1.1.** This can provide a clear idea of countries' ranking based on their Medal winnings in various sports.
  - **1.2.** This can demonstrate which countries excel in sports.

To answer these questions, I created a method to rank countries by their medals. If two countries have the same number of medals, we need a way to decide which one is better than the other. We can’t rank them by numbers alone, because medals have different types: **Bronze**, **Silver**, and **Gold**. For example, a country with **10 Gold medals** is higher than a country with **10 Bronze medals**, though they have the same total number of medals.

## Medal Points Explanation

I ranked countries by their medals in different sports using the Medal Points Method. Each medal point is worth one set of medals, which has one gold 🥇, one silver 🥈, and one bronze 🥉 medal. A set of medals is worth 6 points. The points are calculated based on the values below.

**1** Gold Medal   🥇= **3** points  
**1** Silver Medal 🥈= **2** points  
**1** Bronze Medal 🥉= **1** points  

For instance, if a country has won **10 Gold Medals**, **15 Silver Medals**, and **20 Bronze Medals**, then its total **Medal Points** would be ->   
= **((10\*3)+(15\*2)+(20*1))/6**   
= **13.33** ≈ **13**  
<br>
<br>
**1.1. Countries ranking based on their Medal winnings in various sports:** 

<div align="center">
<table style="border: none; border-collapse: collapse; width: 100%;">
<tr>
  <td>
   <img src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/SM%20Q1.png" alt="SM Q1" width="100%">
  </td>
  <td>
   <img src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/SF%20Q1.png" alt="SF Q1" width="100%">
  </td>
  <td>
   <img src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/WM%20Q1.png" alt="WM Q1" width="94%">
  </td>
  <td>
   <img src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/WF%20Q1.png" alt="WF Q1" width="100%">
  </td>
 </tr>
</table>

<table style="border: none !important; border-collapse: collapse; border-spacing: 0; margin: 0; padding: 0; width: 100%;">
    <tr>
      <td align="center" style="border: none !important; margin: 0; padding: 0; width: 25.5%;">
        <small><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Summer Male&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></small>
      </td> 
      
<td align="center" style="border: none !important; margin: 0; padding: 0; width: 25.5%;">
        <small><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Summer Female&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></small>
      </td> 
      
<td align="center" style="border: none !important; margin: 0; padding: 0; width: 25.5%;">
        <small><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Winter Male&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></small>
      </td> 
      
<td align="center" style="border: none !important; margin: 0; padding: 0; width: 25.5%;">
        <small><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Winter Female&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></small>
      </td>
    </tr>
</table>
</div>

_To view the full list in spreadsheets, [click here](https://docs.google.com/spreadsheets/d/1oqJV3S9_qL5VndFNTljQNE0McKLaFjMqRjlywBcFf4Q/edit?gid=51880459#gid=51880459)_  
<br>  
**1.2. Demonstration of which countries are good at sports (based on Medal Points Ranking).**

You might have noticed in the earlier images that three countries were common across all the result sets. They are: the **USA**, **Russia**, and **Germany**. Therefore, we can easily recognize them as the **best-performing** country in Olympic history. Besides them, there are a few countries that have a significant number of wins in their Olympic career. Among them are the **UK**, **Italy**, and **France**. I ranked them based on their **total Medal Points** by combining all the result sets we have seen earlier.

<p align='left'>
<img width=320
 	src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/Ranking%20Q1.png" 
	alt="Ranking Q1" >
</p>

_To see the full list in spreadsheets, [click here](https://docs.google.com/spreadsheets/d/1oqJV3S9_qL5VndFNTljQNE0McKLaFjMqRjlywBcFf4Q/edit?gid=2127167596#gid=2127167596)_
<br>
<br>
<br>
**2. What Sports are most popular?**
  - **2.1.** In each country?
  - **2.2.** Of all time?

In this scenario, participation rate is the criterion for determining the popularity of a sport. That means the more people participate in a sport, the more popular it is.  
<br>
**2.1. Sports popularity in Different countries.** 

<div align="center" style="width: 100%;">
  
  <table style="border: none !important; border-collapse: collapse; border-spacing: 0; margin: 0; padding: 0; width: 100%;">
    <tr>
      <td style="border: none !important; margin: 0; padding: 10px; *width: 80%; vertical-align: top;">
        <img src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/Q2%20P1.png" alt="Q2 P1" width=310>
      </td>
      
<td style="border: none !important; margin: 0; padding: 10px; width: 40%; vertical-align: top;">
        
**Country :**  
Name of the countries.  

**Sports :**  
Name of the most participated sport for a country in that specific table.  

**Total Participation :**  
The number of total participation of a country in that specific sport.
        
</td>
</tr>
</table>
  
</div>

_To view the full list, [click here](https://docs.google.com/spreadsheets/d/1MFsEaD5LD8L94DMGFYJK67B1Kz9VkKHb0iBeZGNW26A/edit?gid=316067201#gid=316067201)_  
<br>
<br>
**2.2. Sports popularity of all time.**

<div align="center" style="width: 100%;">
  
  <table style="border: none !important; border-collapse: collapse; border-spacing: 0; margin: 0; padding: 0; width: 100%;">
    <tr>
      <td style="border: none !important; margin: 0; padding: 10px; width: 80%; vertical-align: top;">
        <img src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/Q2%20P2.png" alt="Q2 P2" height=290>
      </td>
      
<td style="border: none !important; margin: 0; padding: 10px; width: 40%; vertical-align: top;">
        
**Total Participants :**    
Total number of participants for specific sports in that table. <br>(Listed in Descending order)
        
</td>
</tr>
</table>
  
</div>

_To see the full list, [click here](https://docs.google.com/spreadsheets/d/1MAwqqA8FZuNzAVA7KMixxwgMTGCuxgCZshwAK7-OJ4g/edit?gid=156587825#gid=156587825)_  
<br>
<br>
**3. Which country is best in which sport?**
 - **3.1.**	 Based on Sports
 - **3.2.**	 Based on Countries

It can have two possible result sets. One could be based on the sports while the other could be based on the countries. That’s why I am dividing the question into two parts even though I had only one question for this at the initial state.  

**3.1. Best performer country in different sports (Sports Based)**

<div align="center" style="width: 100%;">
<table style="border: none !important; border-collapse: collapse; border-spacing: 0; margin: 0; padding: 0; width: 100%;">
<tr>	
<td style="border: none !important; margin: 0; padding: 10px; width: 40%; vertical-align: top;">

**Sports :**  
Name of the Sports.  

**Country :**  
Name of the **Country** that is the best performer in that **Sport** <br> across that table.  

**Medal Points :**  
Total **Medal Points** the country have earned in that particular **Sport** <br> in that table.        
</td>
<td style="border: none !important; margin: 0; padding: 10px; width: 80%; vertical-align: top;">
        <img src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/Q3%20P1.png" alt="Q3 P1" height=310>
</td>
</tr>
</table>
</div>

_To view the full list, [click here](https://docs.google.com/spreadsheets/d/1yBdz8PXNtNQAobQXivWLfPyIJ82bq04M_TdqaXkhvxc/edit?gid=133644499#gid=133644499)_

_N.B.: If a sport is not listed, it means that all participating countries have earned **0** Medal Points in that sport, indicating that no country excels in it._  
<br>
<br>
**3.2. Countries’ best performance in different sports (Country Based)**

<div align="center" style="width: 100%;">
<table style="border: none !important; border-collapse: collapse; border-spacing: 0; margin: 0; padding: 0; width: 100%;">
<tr>	
<td style="border: none !important; margin: 0; padding: 10px; width: 40%; vertical-align: top;">

**Country :**  
Name of the **Countries**.  

**Sports :**  
Name of the **Sport** that the country has performed its best in <br> across that table.  

**Medal Points :**  
Total **Medal Points** the country have earned in that **Sport** <br> in that table.        
</td>
<td style="border: none !important; margin: 0; padding: 10px; width: 80%; vertical-align: top;">
        <img src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/Q3%20P2.png" alt="Q3 P2" height=310>
</td>
</tr>
</table>
</div>

_To view the complete list, [click here](https://docs.google.com/spreadsheets/d/1SPNzIW5KT27LRP70Yvnx-VBuANNj7KBj7n2FlOM6LNc/edit?gid=2011932197#gid=2011932197)_

_N.B.: If a country is not listed, it means that the country has **0** Medal Points in all the sports it participated in._  
<br>
<br>
**4. What are the beginning and ending years of participation of each country?** 

To answer this question, we need to look at the visualization of the participation rate that I used to determine the separation of **Seasons** and **Genders**.

<p align='left'>
<img height=600
 	src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/Main%20Analysis%20Participation%20Rate.png" 
	alt="Main Analysis Participation Rate" >
</p>

From this visualization, we see the last **Summer Olympics** was in **2016** and the last **Winter Olympics** in **2014**. If a country last participated in **2016** Summer Olympics, it’s likely still participating. Similarly for winter olympics, if a country last participated in **2014**, the country is likely still involved. For countries that stopped participating before these years, the end year is provided in the result set.

<p align='left'>
<img height=280
 	src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/Q4.png" 
	alt="Q4" >
</p>

_To see the full list, [click here](https://docs.google.com/spreadsheets/d/1lSZlIELjC06nAuX-HEb8zOJN0ER8XVEFwLnD0K88lnY/edit?gid=341606770#gid=341606770)_  
<br>
<br>
**5. What is the average Age, Weight, and Height of athletes in different sports?**

To answer this question, I used the **mean** as the average.

<p align='left'>
<img width=520
 	src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/Q5.png" 
	alt="Q5" >
</p>

_To see the full list, [click here](https://docs.google.com/spreadsheets/d/1nbFTbu1txn1IeEZHe-R33gtF1vqk11KQbBUreu9KVTc/edit?gid=1644641817#gid=1644641817)_   

_N.B.: You will notice some **NULL**s across the result sets; they are created because all the corresponding data values that are supposed to be used for the calculation were **NULL**s._   
<br>
<br>
**6. Is there anything hidden in the age range?**

There are multiple ways to approach this question. I used the participation rate of different ages to assess their significance in future data samples. For example, to determine the success rate of various height and weight ranges, we need to understand the composition of the data sample to accurately represent the entire population. This approach also helps prevent bias in the results.

To answer the question in the way described above, we need to assess **2** key things from the data. They are :-

1. The **Range of Age** in the Tables.  
2. The **participation in Unique Sports** for all ages.


To understand these two points, we need to recall the number of Unique Sports in the Tables.

- **Summer   Male** : 	**44** Unique Sports
- **Summer Female** : 	**35** Unique Sports
- **Winter   Male** : 	**16** Unique Sports
- **Winter Female** : 	**14** Unique Sports  

<!--- SM Q6-->
<div align="center" style="width: 100%;">
<table style="border: none !important; border-collapse: collapse; border-spacing: 0; margin: 0; padding: 0; width: 100%;">
<tr>	

<td style="border: none !important; margin: 0; padding: 10px; width: 20%; vertical-align: top;">
        <img src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/SM%20Q6.png" alt="SM Q6" height=270>
</td>
<td style="border: none !important; margin: 0; padding: 10px; width: 80%; vertical-align: top;">
        <img src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/SM%20Q6%20Distribution.png" alt="SM Q6 Distribution" width=610>
</td>
</tr>
</table>
</div>
<p align="center">
	<strong>Summer Male</strong>
</p>
<br>
<!--- SF Q6-->
<div align="center" style="width: 100%;">
<table style="border: none !important; border-collapse: collapse; border-spacing: 0; margin: 0; padding: 0; width: 100%;">
<tr>	

<td style="border: none !important; margin: 0; padding: 10px; width: 20%; vertical-align: top;">
        <img src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/SF%20Q6.png" alt="SF Q6" height=270>
</td>
<td style="border: none !important; margin: 0; padding: 10px; width: 80%; vertical-align: top;">
        <img src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/SF%20Q6%20Distribution.png" alt="SF Q6 Distribution" width=610>
</td>
</tr>
</table>
</div>
<p align="center">
	<strong>Summer Female</strong>
</p>
<br>
<!--- WM Q6-->
<div align="center" style="width: 100%;">
<table style="border: none !important; border-collapse: collapse; border-spacing: 0; margin: 0; padding: 0; width: 100%;">
<tr>	

<td style="border: none !important; margin: 0; padding: 10px; width: 20%; vertical-align: top;">
        <img src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/WM%20Q6.png" alt="WM Q6" height=270>
</td>
<td style="border: none !important; margin: 0; padding: 10px; width: 80%; vertical-align: top;">
        <img src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/WM%20Q6%20Distribution.png" alt="WM Q6 Distribution" width=610>
</td>
</tr>
</table>
</div>
<p align="center">
	<strong>Winter Male</strong>
</p>
<br>
<!--- WF Q6-->
<div align="center" style="width: 100%;">
<table style="border: none !important; border-collapse: collapse; border-spacing: 0; margin: 0; padding: 0; width: 100%;">
<tr>	

<td style="border: none !important; margin: 0; padding: 10px; width: 20%; vertical-align: top;">
        <img src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/WF%20Q6.png" alt="WF Q6" height=270>
</td>
<td style="border: none !important; margin: 0; padding: 10px; width: 80%; vertical-align: top;">
        <img src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/WF%20Q6%20Distribution.png" alt="WF Q6 Distribution" width=610>
</td>
</tr>
</table>
</div>
<p align="center">
	<strong>Winter Female</strong>
</p>


You might have noticed the term ‘**PIUS**,’ which stands for ‘**Participation In Unique Sports**.’ It indicates the number of unique sports athletes of a certain age have participated in. e.g. in the **Summer Male** table, there are **5,927** athletes aged **19** who have participated in **35** different sports. Although the table includes **44** unique sports, participating in **35** is still significant. Therefore, athletes aged **19** are important for future analytics.

The visualizations earlier show that individuals aged **18** to **35** are most likely to participate in more unique sports. Athletes younger or older than this range are less likely to participate in multiple sports. The visualizations also reveal that the data is skewed towards younger athletes, which can be confirmed by looking at the ‘**Total Participants**’ of different ages in this [spreadsheet](https://docs.google.com/spreadsheets/d/1pf9Al9BC60DAzVdsowbRAtwRAyjWvNocbALz405XVVQ/edit?gid=297404889#gid=297404889).

Therefore, we can say that the skewness of different types was hidden in the age.

---  
---  

# Testing Hypotheses

**A. Youngsters(18-35) are more likely to win competitions than oldsters(35+).**
  - Since Younger people are likely more energetic than older people.

From the answer to the last question of the previous section, we confirmed that the data was skewed towards younger **(18-35)** athletes. That means a big portion of the data is covered with the athletes of this age range. So there is a high chance to be biased by the result from a hypothesis like this. Regardless of the possibility of being biased, let’s compare two age ranges to determine whether the hypothesis is correct or not. 

As the age range of '**18-35**' has a total of **18** ages in it, let’s consider another age range of older athletes with the same number of ages within that age range. Let’s consider '**36-53**'.

**Range A = 18-35**  
**Range B = 36-53**

Let’s look at their total Participants and Medal winnings.

<p align='left'>
<img width=520
 	src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/H1.png" 
	alt="H1" >
</p>

As you can see, both ranges have a similar **ratio** of medal winnings despite the significant difference in their **sample sizes**. This disparity makes it **unreliable** for **predicting future outcomes**. Even if the distribution appears **symmetrical**, random samples from these ranges are more likely to miss parts of the actual population. This could lead to biases by **over-prioritizing** or **under-prioritizing** certain segments of the population. That's why I say this hypothesis was **inappropriate**.

In the earlier picture, we were viewing the **Summer Male** table and comparing two different Age groups, considered as **A(18-35)** and **B(36-53)**. The **Ratio** is calculated by dividing the **Total Participants** of an Age group by its **Total Medal Wins**. In the case of **Summer Male** table, we can see that both Age Groups’ **Medal winning Ratio** is very close to each other, providing the insight that their **Total Participants : Total Medal Wins** ratio is **symmetrical**. Keeping only these insights in consideration can help us understand the underlying pattern of the data, but future predictions will more likely be unreliable and inappropriate.

However, let’s see how this hypothesis is working for different tables.

I am providing only the outcomes from the tables. You can confirm these insights by viewing this [Spreadsheet](https://docs.google.com/spreadsheets/d/1--rITmJqS8966Eo8gYWeT7n-TQz_1v40sXZkDHzX_go/edit?gid=1871221069#gid=1871221069).

 **1. Summer Male:**  
 **A(18-35):** Out of every **6** athletes, **1** is likely to win a medal.  
 **B(36-53):** Out of every **6** athletes, **1** is likely to win a medal.  
The Hypothesis was **wrong**, and the outcome is **Neutral**. **A:B** = **6 : 6**  
\-  
  
 **2. Summer Female:**  
 **A(18-35):** Out of every **6** athletes, **1** is likely to win a medal.  
 **B(36-53):** Out of every **8** athletes, **1** is likely to win a medal.  
The Hypothesis was **correct**, and the outcome is **Positive**. **A:B** = **6 : 8**  
\-  
  
 **3. Winter Male:**  
 **A(18-35):** Out of every **9** athletes, **1** is likely to win a medal.  
 **B(36-53):** Out of every **7** athletes, **1** is likely to win a medal.  
The Hypothesis was **wrong**, and the outcome is **Negative**. **A:B** = **9 : 7**  
\-  
  
 **4. Winter Female:**  
 **A(18-35):** Out of every **8** athletes, **1** is likely to win a medal.  
 **B(36-53):** Out of every **5** athletes, **1** is likely to win a medal.  
The Hypothesis was **wrong**, and the outcome is **Negative**. **A:B** = **8 : 5**

---  

**B. The weight and height of the players matter together. (BMI - Body Mass Index)**
  - Overweight people are more likely to win fewer competitions.

Before testing the hypothesis, I want to divide the athletes into **2** parts instead of **4** defined in the earlier scenarios. Instead of two categories for **Season** and two for **Sex**, I want to keep the category only for **Sex**. That means this hypothesis will be tested based on **Sex** and not based on **Season + Sex**. Now, let’s break down what the hypothesis is actually about. 

**BMI(Body Mass Index)** defines a person’s body weight to identify whether he is **underweight** or **overweight**. It is calculated by two pieces of information about a person’s health. 
These are:  
**1. Body Mass**  
**2. Body Height**

The formula for **BMI** calculation is<br><br>$$\text{BMI} = \frac{\text{weight (kg)}}{(\text{height in cm}/100)^2}$$
<br>
<br>

### Result of the hypothesis on Male - (H2 M)

<div align="center" style="width: 100%;">
<table style="border: none !important; border-collapse: collapse; border-spacing: 0; margin: 0; padding: 0; width: 100%;">
<tr>
<td style="border: none !important; margin: 0; padding: 10px; width: 80%; vertical-align: top;">
        <img src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/H2%20M.png" alt="H2 M" height=310>
</td>
<td style="border: none !important; margin: 0; padding: 10px; width: 40%; vertical-align: top;">

**Weight Grp(BMI) :**  
Different Weight Groups with their BMI Ranges.  

**Total Participants :**  
Number of Athletes within that BMI Range.  

**Total Medal Wins :**  
Number of Medal winners within that BMI Range.  

**Success Rate :**  
Percentage of Total Medal winners among Total Participants.  

**PIUS :**  
Participation in UNIQUE Sports. (Same as in the answer to **Q6**)
</td>
</tr>
</table>
</div>

At first glance, the `Success Rate` column might prove that the hypothesis was completely **incorrect**. This is because all overweight groups, except **Obese Type II**, have a higher success rate than the **Normal** Weight group. While they do indeed have a higher success rate, they also have a much lower **PIUS** value compared to normal weight. In other words, the overweight groups (**Obese I** & **Obese III**) have higher success rates than normal weight individuals, but only in a few sports. Therefore, it cannot be said that, on average, they have a higher success rate than Normal-weight individuals.<br>
On the other hand, the **Overweight** group (**BMI 25-29.9**) has a **PIUS** value very close to that of the normal weight group and also has a higher success rate (**+5.5%**) than normal weight individuals. This proves that my hypothesis was **incorrect** for this weight group.<br>
In conclusion, my hypothesis was **incorrect** for the **Overweight** group (**BMI 25-29.9**) but **correct** for the other overweight groups.  
<br>
<br>

### Result of the hypothesis on Female - (H2 F)

<div align="center" style="width: 100%;">
<table style="border: none !important; border-collapse: collapse; border-spacing: 0; margin: 0; padding: 0; width: 100%;">
<tr>
<td style="border: none !important; margin: 0; padding: 10px; width: 80%; vertical-align: top;">
        <img src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/H2%20F.png" alt="H2 F" height=310>
</td>
<td style="border: none !important; margin: 0; padding: 10px; width: 40%; vertical-align: top;">

**Weight Grp(BMI) :**  
Different Weight Groups with their BMI Ranges.  

**Total Participants :**  
Number of Athletes within that BMI Range.  

**Total Medal Wins :**  
Number of Medal winners within that BMI Range.  

**Success Rate :**  
Percentage of Total Medal winners among Total Participants.  

**PIUS :**  
Participation in UNIQUE Sports. (Same as in the answer to **Q6**)
</td>
</tr>
</table>
</div>

Just like males, **females** also have a higher `success rate` in overweight groups (except **Obese II**) compared to the **Normal** weight group. However, after examining the **PIUS** values of different overweight groups, we can confirm that their higher success rate is accurate only in a few sports. Therefore, in general, we cannot consider this success rate applicable to all sports.<br>
On the other hand, the **Overweight** group (**BMI 25-29.9**) has a **PIUS** value very close to that of the **Normal** weight group and also has a higher success rate (+5.05%) than Normal-weight individuals. This proves that my hypothesis was **incorrect** for this weight group.<br>
In conclusion, my hypothesis was **incorrect** for the **Overweight** group (**BMI 25-29.9**) but **correct** for the other overweight groups.

N.B.: 
- **H2 M** has a total of **51** Unique Sports.
- **H2 F** has a total of **48** Unique Sports.

---  

**C. There are some specific reasons for fewer athletes participating in**
  - **Women's sports** - not all countries participate in women's sports, AND/OR women have fewer sports to participate in.
  - **Winter sports** - not all countries participate in the Winter season.

### About Women's Sports

By examining the **SF Q4** sheet from this [spreadsheet](https://docs.google.com/spreadsheets/d/1lSZlIELjC06nAuX-HEb8zOJN0ER8XVEFwLnD0K88lnY/edit?gid=1419609558#gid=1419609558), you will recognize that in the **Summer Olympics**, all the countries that participated in **male** sports also participated in **female** sports. This demonstrates **no difference in national representation** between the two groups.

However, if you look at the [**WF Q4**](https://docs.google.com/spreadsheets/d/1lSZlIELjC06nAuX-HEb8zOJN0ER8XVEFwLnD0K88lnY/edit?gid=901134414#gid=901134414) sheet, you’ll find that many countries do not participate in **female sports** in the **Winter** season. While male athletes from **106** countries participated in the Winter, female athletes came from **82** countries only. It shows that not all countries participate in **women’s** sports, especially during the **Winter** season.

Additionally, as seen in the answer to the **6th** question of the analysis, the **Summer Male** Table lists **44** unique sports, while the **Summer Female** Table lists only **35**. Similarly, the **Winter Male** Table has **16** unique sports, compared to **14** for the **Winter Female** Table. This demonstrates that women have fewer sports than men to participate in, which directly affects their participation rates. Therefore, my hypothesis is **correct**.

### About Winter Sports

From the explanation of the previous part, we can clearly understand the reason for the difference in participation rates between the **Summer** and **Winter** Olympics. Many countries that participate in **Summer** don’t participate in **Winter** season. You can confirm it by looking at the total number of countries listed in every single sheet of this [Spreadsheet](https://docs.google.com/spreadsheets/d/1lSZlIELjC06nAuX-HEb8zOJN0ER8XVEFwLnD0K88lnY/edit?gid=341606770#gid=341606770). Additionally, the Winter Olympics offer significantly fewer sports compared to the Summer Olympics, which likely contributes to the large disparity in participation rates. This supports the conclusion that my hypothesis is **correct**.

# Mixed Events

A Mixed event in the Olympics refers to a sports event where team participants must include both male and female athletes. These events were introduced to promote gender equality in sports.

## Q&A

### Questions  

**1. When were the mixed events first introduced in the Olympics in the Summer and the Winter?**  
**2. Which country when started and stopped participating in such events?**  
**3. How many Unique Sports are there in this event category?**  
**4. Who is the best in it?**  
<br>
<p align='center'>
<img height=600
 	src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-2%20-%3E%20Olympic%20Analysis/Others/Images/Mixed%20Events%20Participation%20Rate.png" 
	alt="Mixed Events Participation Rate" >
</p>
<br>

### Answering Questions 

**1. When were the Mixed events first introduced in the Olympics in different seasons?**  
**Ans:**  The Mixed events were first introduced in the:-  
	**Summer Season** : Year **1900**  
	**Winter Season** : Year **1924**  

**2. Which country when started and stopped participating in such events?**  
**Ans:**  Just like the **main analysis**, If a country stopped participating before **2016** in the **Summer**	Olympics, then its last participation year is shown in the result. Similarly, if a country stopped participating before **2014** in the winter Olympics, then its last participation year is given in the result. You can view the result set from [here](https://docs.google.com/spreadsheets/d/11Yi40SZ7RgtfLi2rSPGjIawj9JeJ0seEkRmIG3VGmnY/edit?gid=1543691228#gid=1543691228).

**3. How many Unique Sports are there in this event category?**  
**Ans:** In the Mixed Events category, there are only **11** sports in **Summer** Olympics, while only **4** in **Winter**. You can check the list [here](https://docs.google.com/spreadsheets/d/1CEUmmJKLYDZN86XuzMxzJH-qgwRPzMAZXYbVs6vb9ZM/edit?gid=0#gid=0).

**4. Who is the best in it?**  
**Ans:** To check this, we need to look at the **Medal Points** of the countries. The result will be based on Sports. Click [here](https://docs.google.com/spreadsheets/d/1dpUFvm6d36rUhijp3bywfMAmOJA_nYfr5bQPr65Sr6k/edit?gid=1345309804#gid=1345309804) to see the result.



# Historical Facts

After analyzing the Olympics, I discovered some historical facts. The modern Olympics began in **1896**, initially only for **men**. **Women** first participated in **1900**, making up just **2.2%** of athletes. This gender disparity persisted until the late **1900s**. **Post-1992** policy changes have gradually narrowed the gap, with male participation decreasing in **Summer** but slightly increasing in **winter**.

Due to the two **world wars**, no **Olympics** were held during those periods. From **1896** to **1992**, the Olympics occurred every four years. The **first Winter Olympics** was introduced in **1924**, and both **Summer** and **Winter** Olympics were held in the **same year until 1992**. Since then, the interval between the same seasonal Olympics is **4** years, and between different seasonal Olympics is **2** years.

To promote gender equality, the **IOC** introduced mixed events in **1900**, requiring both genders to participate. However, significant changes only occurred after **1992**, leading to better gender balance. We can expect a **1:1** **gender ratio** in future Olympics. The Olympics also promote age equality, proving **sports are for everyone**.
