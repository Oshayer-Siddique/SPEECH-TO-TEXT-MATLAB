# 🇧🇩 Bangla Isolated Word Recognition using MFCC + DTW (MATLAB)

This project implements a **simple and effective speech recognition system** for **isolated Bangla words** using:

- **MFCC** (Mel-Frequency Cepstral Coefficients) for feature extraction
- **DTW** (Dynamic Time Warping) for template-based matching

---

## 🎯 Supported Bangla Words

The system currently supports recognition of the following 5 isolated Bangla words:

- **"আসুন"** (ashun)
- **"হ্যাঁ"** (ha / yes)
- **"না"** (na / no)
- **"বিদায়"** (biday / goodbye)
- **"বন্ধ"** (bonfho / stop)

---

## 🧠 Conceptual Overview

### 🔊 1. MFCC — Feature Extraction

MFCCs are a compact representation of the audio signal that approximates how humans perceive sound, especially speech.

#### MFCC Steps:
1. **Pre-emphasis**
2. **Framing & Windowing**
3. **FFT** to get the power spectrum
4. **Mel Filterbank** to approximate human ear
5. **Logarithm** of filterbank energies
6. **DCT (Discrete Cosine Transform)** to decorrelate

Let \( x(t) \) be the time-domain signal. After FFT and Mel filtering:
\[
\text{MFCC}_k = \sum_{n=1}^{N} \log(E_n) \cdot \cos\left[\frac{\pi k(n - 0.5)}{N}\right]
\]
Where:
- \( E_n \): Energy in Mel filterbank \( n \)
- \( N \): Number of filters
- \( k \): MFCC coefficient index

---

### 📐 2. DTW — Template Matching

**Dynamic Time Warping** aligns sequences of varying lengths by computing an optimal match that minimizes the distance.

Given two sequences:
- \( X = [x_1, x_2, ..., x_n] \)
- \( Y = [y_1, y_2, ..., y_m] \)

A **cost matrix \( D \in \mathbb{R}^{n \times m} \)** is created:
\[
D(i, j) = \| x_i - y_j \|_2
\]

We then compute the accumulated cost matrix \( C(i, j) \) recursively:
\[
C(i,j) = D(i,j) + \min \left( C(i-1,j), C(i,j-1), C(i-1,j-1) \right)
\]

The final DTW distance is \( C(n, m) \) — the minimal cost path.

---

## 🗂️ Project Structure


