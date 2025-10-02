# Project Overview

This analysis is performed on the **Olympic Sports events** and **participants** over a time span of **120 years**. This analysis can reveal the patterns and factors that influence Olympic Sports performance and participation, which can be useful for news reporters, sports enthusiasts, and anyone curious about the Olympics.


# Data Structure Overview

The dataset provider has **2** datasets regarding the Olympics.

These include:

- **athletes_events :** This dataset includes demographic information about individual athletes. It also provides information about the participated events of each athlete. Additionally, it includes the NOC code as well as the Medal type of an athlete if they have won an event.
  -  Records: 271,116 

- **noc_regions :** This Table includes information about Distinct NOC codes and the region/country they represent.
  - Records: 230 

# Summary of the Analysis

- The **USA**, **Russia**, and **Germany** have the best athletes, proven by their numerous Olympic medals. This shows their serious commitment to sports performance.

- Popular sports like **athletics**, **gymnastics**, and **swimming** have many participants, increasing competition compared to less-known sports.

- Less-known sports have fewer participants, giving countries with less focus on sports a higher chance of winning.

- Countries should train athletes in multiple sports, not just one or two, to avoid failure. The Olympics is about continuous improvement, so diversifying can help find a sport they excel in.

- Many countries stop participating in the Olympics after a few attempts due to a lack of success. They should try all sports to find where they can win medals and then train their athletes accordingly.

- While training is crucial, factors like age, height, weight, and BMI also matter in the Olympics. For example, a 10-year-old can’t outrun a 25-year-old, and an 8-foot-tall player has an advantage in           basketball over a 5-foot-tall player.

- Countries without cold climates are less likely to participate in the Winter Olympics. They struggle to train athletes for cold conditions, affecting performance. Solutions are needed from both countries and the IOC(International Olympic Committee).

- The Winter Olympics have fewer sports due to less participation. It should offer as many sports as the Summer Olympics to increase interest and participation.

- Many countries don’t participate in women’s sports. The IOC should promote gender, cultural, and racial equality to ensure no one is left behind in the Olympics.


# Questions & Hypotheses

## Questions:

**1. Which Countries have won the highest Number of Medals?**
  - **1.1.** This can provide a clear idea of countries' rankings based on their Medal winnings in various sports.
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

**B. The weight and height of the players matter together.(BMI)**
  - Overweight people are more likely to win fewer competitions.

**C. There are some specific reasons for less athletes participating in**
  - Women's sports - not all countries participate in women's sports AND/OR women have fewer sports to participate in.
  - Winter sports - not all countries participate in the Winter season.

# Answering Question

Before jumping into the actual analysis, I discovered some skewness in the data, and it can’t be fixed without dividing the data into multiple parts and analyzing each part separately. First, I’m gonna divide the dataset for two different seasons, ‘SUMMER’ and ‘WINTER’, and then I’m gonna divide these two parts again into two more parts. One for males and the other for females.
So I have 4 new tables.

- Summer Male
- Summer Female
- Winter Male
- Winter Female

While performing EDA(Exploratory Data Analysis), I found that the Event column correlates with the Sex column. If the Event name contains the word “Men’s”, the Sex column value is ‘M’, indicating a Male, Likewise, if the Event name contains the word “Women’s” then the Sex column value is ‘F’ indicating a Female, which is a usual thing. But some Event names do not contain either, but rather contains a common word ‘Mixed’ across the column.
This indicates that the sport is for both ‘Male’ & ‘Female’, and most of these sports have double participants where one of them is a ‘Male’ and the other is a ‘Female’. Therefore, these events can’t be considered specific to Sex, nor can they be analyzed by including these records in the 4 tables I mentioned earlier, because those 4 tables are gender specific. That's why I analyzed these Mixed events separately, and they are described at the very end of the project.


- 1. Which Country has won the highest Number of Medals?
	This can give a clear idea of country rankings based on their Medal winnings in various sports.
	This can give a demonstration of which countries are better at sports.

To answer these questions, I used a method to rank countries by their medals. If two countries have the same number of medals, we need a way to decide who is higher or lower. We can’t rank them by number alone, because medals have different types: Bronze, Silver, and Gold. For example, a country with 10 Gold medals is higher than a country with 10 Bronze medals, though they have the same total number of medals.

## Medal Points Explained :

I ranked countries by their medals in different sports using the Medal Points Method. Each medal point is worth one set of medals, which has one gold 🥇, one silver 🥈, and one bronze 🥉 medal. A set of medals is worth 6 points, the points are calculated based on the values below.

1 Gold Medal   🥇= 3 points
1 Silver Medal 🥈= 2 points
1 Bronze Medal 🥉= 1 point

For example, If a country has won 10 Gold Medals, 15 Silver Medals and  20 Bronze Medals then its total Medal points would be -> 
				((10*3)+(15*2)+(20*1))/6
				= 13.33 ≈ 13
1.1.1. country rankings based on their Medal winnings in various sports: 
		Top 10 countries with the highest number of Medal Points.

[img]  | [img]
------|------
[img] | [img]

To view the full list in spreadsheets, click here

1.1.2. Demonstration of which countries are better at sports(based on Medal Points Ranking).
As you might have noticed in the earlier slide that three countries were common across all the result sets. They are: the USA, Russia, and Germany. Therefore, we can easily recognize them as the best performing country in Olympic history. Besides them, there are a few countries that have a significant number of wins in their Olympic career. Among them are the UK, Italy, and France. I ranked them based on their total Medal Points by combining all the result sets we have seen earlier.

[img]

To see the full list in spreadsheets, click here

- 2. What Sports are most popular?
	2.1.	In each country
	2.2.	Of all time

In this scenario participation rate is the criterion for determining the popularity of a sport. That means the more people participate in a sport, the more popular it is.

2.2.1. Sports popularity in Different countries.

[img] (on the left) | 	Country: Name of the countries.

			Sports: Name of the most participated sport for a country in that specific table.           

			Total Participation: The number of total participation of a country in that specific sport. 

View the full list, click here

2.2.2. Sports popularity of all time.

[img]

Total Participants : Showing the total number of participants for different sports in that table. (Listed in Descending order)

To see the full list, click here


- 3. Which country is best in which sport?
		3.1	 Based on Sports
		3.2	 Based on Countries

It can have two possible result sets. One could be based on the sports while the other could be based on the countries. That’s why I am dividing the question into two parts even though I had only one question for this at the initial state. 

3.3.1. Best performer country in different sports( Sports Based)

Sports: Name of the Sports. [img](on the right)

Country: Name of the Country that is the best performer in a particular Sport across that table. (e.g. Summer Male in this case). 

Medal Points: Total Medal points the country have earned in that particular Sport within that result set.

To view the full list, click here

N.B.: If a sport is not listed, it means that all participating countries have earned 0 Medal Points in that sport, indicating that no country excels in it.


3.3.2. Countries’ best performance in different sports( Country Based)

Country: Name of the Countries. [img](on the right)

Sport: Name of the Sport that the country has performed their best in across that table. (e.g. Summer Male in this case). 

Medal Points: Total Medal points the country have earned in that Sport within that result set.

N.B.: If any Country’s name is not listed then it means the country have 0 Medal Points in all of its participated sports.

4. What is the beginning and ending year of participation of each country? 

To answer this question we need to look at the visualization of the participation rate that I used to determine the separation of Seasons and Genders.

[img] 

From the earlier visualization, we see the last Summer Olympic was in 2016 and the last Winter Olympic in 2014. If a country last participated in the 2016 Summer Olympic, it’s likely still participating. Similarly, if the last participation was in the 2014 Winter Olympic, the country is likely still involved. For countries that stopped participating before these years, the end year is provided in the result set.

[img](on the left) | To see the full list, click here

- 5. What is the average Age, Weight and Height of athletes in different sports?

To answer this question, I used mean as the average.

[img]

N.B.: You will notice some NULLs across the result sets, they are created because all the corresponded data values that are supposed to be used for the calculation were NULLs. 

- 6. Is there anything hidden in the age range?

There are multiple ways to approach this question. I used the participation rate of different ages to assess their significance in future data samples. For example, to determine the success rate of various height and weight ranges, we need to understand the composition of the data sample to accurately represent the entire population. This approach also helps prevent bias in the results.

To answer the question in the way described above, we need to look at several key points of the data. They are :-
i. The Range of Age in the Tables/Datasets.
ii. The athletes participation in Unique Sports for all the ages.


To understand these two points we need to recall the number of Unique Sports in the Tables.

Summer Male	: 44 Unique Sports
Summer Female	: 35 Unique Sports
Winter Male	: 16 Unique Sports 
Winter Female	: 14 Unique Sports

[img sheet] | [img histogram]
[img sheet] | [img histogram]
[img sheet] | [img histogram]
[img sheet] | [img histogram]

You might have noticed the term ‘PIUS,’ which stands for ‘Participation In Unique Sports.’ It indicates the number of unique sports athletes of a certain age have participated in. For example, in the Summer Male table, there are 5,906 athletes aged 19 who have participated in 35 different sports. Although the table includes 44 unique sports, participating in 35 is still significant. Therefore, athletes aged 19 are important for future analytics.

The visualizations in the earlier slides show that individuals aged 18 to 35 are most likely to participate in more unique sports. Athletes younger or older than this range are less likely to participate in multiple sports. The visualizations also reveal that the data is skewed towards younger athletes, which you can confirm by looking at the ‘Total Participants’ of different ages in the [spreadsheet].

So, we can say now that the skewness of different types were hidden in the age.

# Testing Hypotheses

A. Youngsters(18-35) are likelier to win competitions than oldsters(35+). 
	- Since younger people are more energetic than older.

From the answer to the last question of previous section, we confirmed that the data was skewed towards the younger(18-35) athletes. That means a big portion of the data is covered with the athletes of this age range. So there is a high Chance to be biased about a result from a hypothesis like this one. Let’s compare two age ranges to determine whether the hypothesis is appropriate or not. 

As the age range of 18-35 has a total of 18 ages in it, let’s consider another age range of older athletes with the same number of ages within that age range. Let’s consider 36-53.

Range A = 18-35
Range B = 36-53

Let’s look at their total Participants and Medal winnings.

[img]

As you can see, both ranges have a similar ratio of medal winnings despite the significant difference in their sample sizes. This disparity makes it unreliable for predicting future outcomes. Even if the distribution appears symmetrical, random samples from these ranges are more likely to miss parts of the actual population. This could lead to biases by over-prioritizing or under-prioritizing certain segments of the population. So I will say the hypothesis was inappropriate in this situation.

Here we are viewing the Summer Male table and comparing two different Age groups, considered as A(18-35) and B(36-53). The Ratio is calculated by dividing the Total Participants of an Age group by its Total Medal Wins. In the case of Summer Male table, we can see Both Age Group’s Medal winning Ratio is very close to each other, providing the insight that their data distribution is symmetrical. Keeping only these insights in consideration can help us understand the underlying pattern of the data, But future prediction will more likely to be unreliable and inappropriate.


However, let’s see how this hypothesis is working for different tables.

I am providing only the outcomes from the tables. You can confirm these insights By looking at this [Spreadsheet].

1. Summer Male:
A(18-35): Out of every 6 athletes, 1 is likely to win a medal.
B(36-53): Out of every 6 athletes, 1 is likely to win a medal. 

The Hypothesis was wrong, and the outcome is Neutral. A:B = 6 : 6

2. Summer Female:
A(18-35): Out of every 6 athletes, 1 is likely to win a medal.
B(36-53): Out of every 8 athletes, 1 is likely to win a medal. 

The Hypothesis was correct, and the outcome is Positive. A:B = 6 : 8

3. Winter Male:
A(18-35): Out of every 9 athletes, 1 is likely to win a medal.
B(36-53): Out of every 7 athletes, 1 is likely to win a medal. 

The Hypothesis was wrong , and the outcome is Negative. A:B = 9 : 7

4. Winter Female:
A(18-35): Out of every 8 athletes, 1 is likely to win a medal.
B(36-53): Out of every 5 athletes, 1 is likely to win a medal. 

The Hypothesis was wrong , and the outcome is Negative. A:B = 8 : 5


B. The weight and height of the players matter together. (BMI - Body Mass Index)
	- Overweight people are likelier to win less competitions.

Before testing the hypothesis, I want to divide the athletes into 2 parts instead of 4 parts defined in the earlier scenarios. Instead of two category for Seasons and two for Sex/Gender, I want to keep the category only for Sex/Gender. That means this hypothesis will be test based on Sex and not based on Season + Sex. Now let’s break what the hypothesis is actually about. 

BMI(Body Mass Index) defines a person’s body weight to identify whether he is underweight or overweight based on his/her Health condition. It is calculated with two data of a person’s health. 
These are:
 i. Body Mass
ii. Body Height

The formula to BMI calculation is
[img]

## Testing the hypothesis for Male

[img](on the left) | 

Weight Grp(BMI): Different Weight Groups with their BMI Ranges.
Total Participants: Number of Athletes within that BMI Range.
Total Medal Wins: Number of Medal winners within that BMI Range.
Success Rate: Percentage of Total Medal winners among Total Participants.
PIUS: Participation in UNIQUE Sports. (Same as Section-1 Q6)
(on the right)

At first glance, the Success Rate column might prove that the hypothesis was completely incorrect. This is because all overweight groups, except for Obese Type II, have a higher success rate than the Normal Weight group. While they do indeed have a higher success rate, they also have a much lower PIUS value compared to normal weight individuals. In other words, the overweight groups (Obese I & Obese III) have higher success rates than normal weight individuals, but only in a few sports. Therefore, it cannot be said that, on average, they have a higher success rate than normal weight individuals.
On the other hand, the Overweight group (BMI 25-29.9) has a PIUS value very close to that of the normal weight group and also have a higher success rate (5.5%+) than normal weight individuals. This proves that my hypothesis was incorrect for this weight group.
In conclusion, my hypothesis was incorrect for the Overweight group (BMI 25-29.9) but correct for the other overweight groups.

[img](on the left) | 

Weight Grp(BMI): Different Weight Groups with their BMI Ranges.
Total Participants: Number of Athletes within that BMI Range.
Total Medal Wins: Number of Medal winners within that BMI Range.
Success Rate: Percentage of Total Medal winners among Total Participants.
PIUS: Participation in UNIQUE Sports. (Same as Section-1 Q6)
(on the right)

Just like males, females also have a higher success rate in overweight groups (except Obese II) compared to the normal weight group. However, after examining the PIUS values of different overweight groups, we can confirm that their higher success rate is accurate only in a few sports. Therefore, in general, we cannot consider this success rate applicable to all sports.
On the other hand, the Overweight group (BMI 25-29.9) has a PIUS value very close to that of the normal weight group and also have a higher success rate (5.05%+) than normal weight individuals. This proves that my hypothesis was incorrect for this weight group.
In conclusion, my hypothesis was incorrect for the Overweight group (BMI 25-29.9) but correct for the other overweight groups.

N.B.: 
- H2 M has a total of xx Unique Sports.
- H2 F has a total of xx Unique Sports.


C. 3.There are some specific reasons for less athletes participating in 
	- Women sports - not all country participate in women sports AND/OR women has less sports to participate in.
	- Winter sports - not all countries participate in Winter season.

## About Women Sports

If you examine the SF Q4 sheet of this [spreadsheet], you’ll see that female athletes participate in the Summer Olympics from all the same countries as male athletes. This indicates that there is no difference in country participation between male and female athletes in the Summer Olympics, with all countries participating in both male and female sports.

However, if you look at the [WF Q4] sheet, you’ll find that many countries do not participate in female sports at the Winter Olympics. While male athletes from 106 countries participate in the Winter Olympics, female athletes only come from 82 countries. This shows that not all countries participate in women’s sports, especially during the Winter Olympics.

Additionally, as seen in Section-1 Q6, the Summer Male Table lists 44 unique sports, while the Summer Female Table lists only 35. Similarly, the Winter Male Table has 16 unique sports, compared to 14 for the Winter Female Table. This data demonstrates that women have fewer sports to participate in than men, which directly affects their participation rates. Therefore, my hypothesis is correct.

## About Winter Sports

From the previous passage, we can clearly understand the reason for the difference in participation rates between the Summer and Winter Olympics. A lot of countries that participate in Summer Olympics don’t participate in Winter Olympics. You can confirm it by looking at the total number of countries listed in every single sheet of this [Spreadsheet]. Additionally, Winter Olympics offer significantly fewer sports compared to the Summer Olympics, which likely contributes to the large disparity in participation rates. This supports the conclusion that my hypothesis is correct.

# Mixed Events

A Mixed event in the Olympics refers to a sport event where team participants must include both male and female athletes. These events were introduced to promote gender equality in sports.

## Q&A

### Questions:

1. When Mixed events were first introduced in the Olympics in the Summer and the Winter?
2. Which country when started and stopped participating in such events?
3. How many Unique Sports are there in this event category?
4. Who is the best in it?

[img]

### Answering Questions: 

1. When the Mixed events were first introduced in the Olympics in different seasons?
Ans:  The Mixed events were first introduced in the:-
	Summer Season : Year 1900
	Winter Season : Year 1924

2. Which country when started and stopped participating in such events?
Ans:  Just like the main analysis, If a country stopped participating before 2016 in the Summer	Olympics then its last participation year is showed in the result. Similarly if a country stopped participating before 2014 in the winter Olympics then its last participation year is given in the result. You can view the result set from [here].

3. How many Unique Sports are there in this event category?
Ans: In the Mixed Events category, there are only 11 sports in summer Olympics, while only 4 in Winter. You can check the list [here].

4. Who is the best in it?
Ans: To check this, we need to look at the Medal points of the countries. The result will be based on Sports. Click [here] to see the result.



# Historical Facts

After analyzing the Olympics, we discovered some historical facts. The modern Olympics began in 1896, initially only for men. Women first participated in 1900, making up just 2.2% of athletes. This gender disparity persisted until the late 1900s. Post-1992 policy changes have gradually narrowed the gap, with male participation decreasing in summer but slightly increasing in winter.

Due to the two world wars, no Olympics were held during those periods. From 1896 to 1992, the Olympics occurred every four years. The first Winter Olympics was in 1924, and both Summer and Winter Games were held in the same year until 1992. Since then, the interval between the same seasonal Olympics is four years, and between different seasonal Olympics, two years.

To promote gender equality, the IOC introduced mixed events in 1900, requiring both genders to participate. However, significant changes only occurred after 1992, leading to better gender balance. We can expect a 1:1 gender ratio in future Olympics. The Olympics also promote age equality, proving sports are for everyone.
