System Config: 3rd gen i3 (2 Physical Cores, 4 with hyperthreading), 4GB RAM

### Neural Network

**Test Conditions during benchmark**

- Datset Used: The one given alongside the evaluation scripts (A subset of the orginal data)
- OS: Manjaro 17.1.12 (Arch Linux)
- Implementaion: From Scratch, No External libraries used

**Network Architecture and Parameters used for benchmark**

- Hidden Layers: [100]
- Batch Size: 100
- Initial Learning Rate: 0.01
- Activations: "sigmoid"
- Weights Initialized Randomly near zero

**Benchmark Results**

- Reading Data, Stanardizing it, Training for 50 Epochs, Predicting Labels took: **4minutes 59 seconds**
- ~6 seconds per epoch
- Test Accuracy: **77.099 %**

---

### Naive Bayes

**Stemming and Stopwords Removal:**

- Using `nltk.PorterStemmer()` for stemming
- Entire Training Set: **2 minutes 58 seconds**
- Entire Public Test Set: **1 minute 29 seconds**