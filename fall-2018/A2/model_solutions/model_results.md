## Model Solution Neural Network

|Hidden_Layers|Batch_Size|Activation|η<sub>0</sub>|Epochs|Train_Acc|Public_Test_Acc|
|:-----------:|:--------:|:--------:|:----:|:----:|:-------:|:------:|
|[1000]|100|sigmoid|5|100|96.2302|89.84057|
|[512]|100|sigmoid|5|100|91.4834|86.884|
|[512]|100|tanh|5|100|84.2212|86.884|82.0289|
|[256]|100|sigmoid|5|100|85.555|81.681|

---
### Comments
1. Avoid learning rate > 1. But why? Study it.
2. The loss is summed over number of labels and averaged over number of examples. If we average over both, then SGD is not learning anything? Why?

---

**Adaptive Learning Rate**
Decrease Learning rate only if the loss doesn't decrease

[1000] | 100 | 100 | sigmoid | 0.1 | 81.5
[1000] | 100 | 300 | sigmoid | 0.01 | 81.5

## Model Solution Naive Bayes

Using sklearn MultinomialNB classifer, result on public_test set are as follows:

- **Accuracy Score:** 51.88%
- **Macro-F score:** 33.55%