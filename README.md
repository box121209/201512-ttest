# A-demo-of-the-t-test

This is a demo - <a href="http://54.229.3.49:443/shiny/ttest/">implemented here</a> - of the two-sample (Welch) <i>t</i>-test. 

The idea is that there are two random variables (or populations) <i>A</i> and <i>B</i>, each normally distributed, and we want to test whether these populations have the same mean. So we take a sample from each population. (Shown in the yellow boxplots. The red bar in the boxplot is the sample mean.)

Suppose these samples have size nA,nBnA,nBnA,nB respectively, and that they have means X⎯⎯⎯⎯AX⎯⎯⎯⎯AX⎯⎯⎯⎯A, X⎯⎯⎯⎯BX⎯⎯⎯⎯BX⎯⎯⎯⎯B, and sample variances s2As2As2A, s2Bs2Bs2B. Let
t=X⎯⎯⎯⎯A–X⎯⎯⎯⎯Bswheres=s2AnA+s2BnB‾‾‾‾‾‾‾‾‾√.
t=X⎯⎯⎯⎯A–X⎯⎯⎯⎯Bswheres=s2AnA+s2BnB‾‾‾‾‾‾‾‾‾√.
t=X⎯⎯⎯⎯A–X⎯⎯⎯⎯Bswheres=s2AnA+s2BnB‾‾‾‾‾‾‾‾‾√.

Then one can show that if the (unknown) population means are the same (that’s our null hypothesis) then the variable t, as we repeatedly draw samples, is distributed with a ttt-distribution.
This is what the main plot shows. For each experiment, a sample is drawn from each of AAA and BBB, and the value of ttt is marked as a blue cross on the horizontal axis. For comparison, the grey histogram shows how the blue cross would be distributed over 1000 such experiments. So you can see how typical the value of ttt is for the given population parameters. The red curve is the ttt-distribution under our null hypothesis. So you can also see how typical the blue cross is with respect to this hypothesis. Note that with the starting values of the population parameters the means are equal, so the null hypothesis is met and the red curve matches well to the grey histogram. But explore what happens as the means are moved apart.

The red region in the tail of the ttt-distribution from our blue cross has area which equals the probability, under the null hypothesis, of finding this or a more extreme result. This is the ppp-value of the test.

To be precise, the red curve plots the ttt-density
f(x)=Γ(d+12)dπ‾‾‾√Γ(d2)(1+x2d)−d+12
f(x)=Γ(d+12)dπ‾‾‾√Γ(d2)(1+x2d)−d+12
f(x)=Γ(d+12)dπ‾‾‾√Γ(d2)(1+x2d)−d+12

where ddd is a parameter called the number of degrees of freedom. If one does the maths to derive the distribution of the ttt-statistic under our null hypothesis, one finds a messy formula for ddd:
d=s4(s2A/nA)2nA–1+(s2B/nB)2nB–1
d=s4(s2A/nA)2nA–1+(s2B/nB)2nB–1
d=s4(s2A/nA)2nA–1+(s2B/nB)2nB–1

So as the sample sizes increase, so does ddd, and the red curve f(x)f(x)f(x) becomes more concentrated at 0.
At the bottom of the plot is the output of the R function t.test() for the given samples. It shows, in particular, the value of ttt and the ppp-value. The demo tries to make this output intuitive — how does the ppp-value respond as we vary the population mean and variance, or the sample sizes?

