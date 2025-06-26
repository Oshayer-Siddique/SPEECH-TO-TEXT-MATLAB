# 🇧🇩 Bangla Isolated Word Recognition using MFCC + DTW (MATLAB)

This project implements a **simple and effective speech recognition system** for **isolated Bangla words** using:

- **MFCC** (Mel-Frequency Cepstral Coefficients) for acoustic feature extraction
- **DTW** (Dynamic Time Warping) for robust template matching across variable-length utterances

---

## 🎯 Supported Bangla Words

The system currently supports recognition of the following 5 isolated Bangla words:

- **"আসুন"** (ashun)
- **"হ্যাঁ"** (ha / yes)
- **"না"** (na / no)
- **"বিদায়"** (biday / goodbye)
- **"বন্ধ"** (bonfho / stop)

---

## 🧠 Conceptual and Mathematical Overview

---

### 🔊 1. MFCC — Mel-Frequency Cepstral Coefficients

MFCCs are a compact representation of the short-term power spectrum of a sound, based on human auditory perception. They capture the **timbre** of speech and are widely used in speech recognition systems.

#### 📋 Steps in MFCC Computation:

Given a time-domain signal \( x(t) \), the MFCC extraction process includes the following:

1. **Pre-emphasis**  
   Emphasize higher frequencies:
   \[
   x_{\text{pre}}[n] = x[n] - \alpha \cdot x[n - 1] \quad (\alpha \approx 0.95)
   \]

2. **Framing & Windowing**  
   Divide the signal into short frames (e.g., 20–30 ms) with overlap. Apply a Hamming window \( w[n] \) to each frame:
   \[
   x_w[n] = x[n] \cdot w[n] = x[n] \cdot \left(0.54 - 0.46 \cos\left(\frac{2\pi n}{N-1}\right)\right)
   \]

3. **FFT & Power Spectrum**  
   Compute the FFT of each windowed frame:
   \[
   X[k] = \sum_{n=0}^{N-1} x_w[n] e^{-j2\pi kn/N}
   \]
   Then compute the power spectrum:
   \[
   P[k] = \frac{1}{N} |X[k]|^2
   \]

4. **Mel Filterbank**  
   Apply a set of \( M \) triangular filters spaced on the Mel scale:
   \[
   \text{Mel}(f) = 2595 \cdot \log_{10} \left(1 + \frac{f}{700}\right)
   \]

5. **Logarithmic Compression**  
   For each filterbank output:
   \[
   E_m = \log\left(\sum_{k=1}^{N} P[k] \cdot H_m[k]\right)
   \]
   where \( H_m[k] \) is the \( m \)-th Mel filter.

6. **Discrete Cosine Transform (DCT)**  
   Apply DCT to decorrelate and obtain MFCCs:
   \[
   \text{MFCC}[n] = \sum_{m=1}^{M} E_m \cdot \cos\left[\frac{\pi n (m - 0.5)}{M}\right], \quad n = 1, \dots, L
   \]

The result is a \( T \times d \) matrix, where:
- \( T \): number of frames
- \( d \): number of cepstral coefficients (typically 12–13)

---

### 📐 2. DTW — Dynamic Time Warping

Dynamic Time Warping is an algorithm for measuring similarity between two temporal sequences that may vary in time or speed. It finds the **optimal alignment path** with minimal cumulative distance.

#### 🧮 Let:

- \( X = [\mathbf{x}_1, \mathbf{x}_2, \dots, \mathbf{x}_N] \in \mathbb{R}^{N \times d} \): MFCCs from the test input
- \( Y = [\mathbf{y}_1, \mathbf{y}_2, \dots, \mathbf{y}_M] \in \mathbb{R}^{M \times d} \): MFCCs from a training template

#### 📏 Step 1: Local Distance Matrix

Compute Euclidean distances:
\[
D(i, j) = \| \mathbf{x}_i - \mathbf{y}_j \|_2 = \sqrt{\sum_{k=1}^{d} (x_i^{(k)} - y_j^{(k)})^2}
\]

#### 🔁 Step 2: Dynamic Programming (Cumulative Distance Matrix)

Define a cost matrix \( C \in \mathbb{R}^{(N+1) \times (M+1)} \) initialized as:
\[
C(0, 0) = 0,\quad C(i, 0) = C(0, j) = \infty
\]

Recursively compute:
\[
C(i, j) = D(i, j) + \min \left\{
\begin{array}{l}
C(i-1, j) \\
C(i, j-1) \\
C(i-1, j-1)
\end{array}
\right.
\]

#### ✅ Step 3: Final DTW Distance

The DTW distance is the minimum cost to align the two sequences:
\[
\text{DTW}(X, Y) = C(N, M)
\]

Lower DTW values indicate better matches.

---

## 🖥️ Example Output


---

## 🗂️ Project Setup

### 📁 Folder Structure

BanglaSpeechRecognition/
├── audio/
│ ├── ashun_1.wav, ashun_2.wav
│ ├── ha_1.wav, ha_2.wav
│ ├── na_1.wav, na_2.wav
│ ├── biday_1.wav, biday_2.wav
│ ├── bonfho_1.wav, bonfho_2.wav
│ └── input.wav
├── create_templates.m
├── main.m
├── extract_mfcc.m
├── preprocess_audio.m
├── normalize_features.m
└── dtw_distance.m

---

## 🚀 How to Use

1. 📥 Record or add WAV files to the `audio/` folder.
2. 🔧 Run `create_templates.m` to extract and store MFCCs.
3. 🧪 Run `main.m` to test `input.wav` and recognize the word.

---

## 📌 Limitations

- Works only for **isolated words**
- Sensitive to **background noise** and **speaker variation**
- Not suitable for **continuous speech recognition**

---

## 💡 Future Improvements

- Add **voice activity detection (VAD)** for automatic speech segmentation
- Use **MFCC + HMM/SVM/CNN** for robust classification
- Train on multiple speakers for speaker-independent recognition
- Implement in real-time or deploy on embedded devices

---

## 🧑‍💻 Author

**Oshayer Siddique**  
Department of Computer Science  
Islamic University of Technology  

---

## 📜 License

MIT License — free to use, modify, and distribute with attribution.

