# Fourier Series
---
![FourierSeries](https://raw.githubusercontent.com/builtree/simulate/master/assets/simulations/FourierSeriesLight.png){: style="height:200px", align=right}

<p align="justify">
A Fourier transform is a way of breaking down a complex function into (infinite) sums of sine and cosine waves. In short, given a smoothie, it finds its recipe. Fourier series is the Fourier transform of a periodic function and it aims to represent the periodic function as a sum of sinusoidal waves. It is analogous to the Taylor series, which represents functions as an infinite sum of monomial terms.</p>

<center>
$S_{n}(x) = \frac{a_{o}}{2}+\sum_{n=1}^{N}(a_{n}\cos(\frac{2\pi nx}{P}) + b_{n}\sin(\frac{2\pi nx}{P}))$
</center>

This sum of sine and cosine waves can also be thought of as a list of phasors. Hence, the Fourier series generates a list of phasors which, when summed together, reproduces the original signal. The below animation shows how this can look like: [^1][^2]

![FourierSeriesPhasors](https://upload.wikimedia.org/wikipedia/commons/b/bd/Fourier_series_square_wave_circles_animation.svg){: style="width:300px; vertical-align: baseline"}
![FourierSeriesPhasors](https://upload.wikimedia.org/wikipedia/commons/1/1e/Fourier_series_sawtooth_wave_circles_animation.svg){: style="width:300px ; vertical-align: baseline" }

Simulate approximates the following waves:

1. Sawtooth function
2. Square function

We have the flexibility to fiddle with the following parameters:

* **N**: The number of phasors (sine and cosine terms) generated

* **Amplitude**: The coefficients ‘a<sub>n</sub>’ and ‘b<sub>n</sub>’

* **Frequency**: The value of ‘n’ to adjust the frequency of sine and cosine terms

[^1]: https://upload.wikimedia.org/wikipedia/commons/b/bd/Fourier_series_square_wave_circles_animation.svg
[^2]: https://upload.wikimedia.org/wikipedia/commons/1/1e/Fourier_series_sawtooth_wave_circles_animation.svg

=== "Light Mode"
    ![FourierSeriesLight](https://raw.githubusercontent.com/builtree/assets/simulate/simulations/FourierSeriesLight.png){: style="width:600px"}
  
=== "Dark Mode"
    ![FourierSeriesDark](https://raw.githubusercontent.com/builtree/assets/simulate/simulations/FourierSeriesDark.png){: style="width:600px"}
    
