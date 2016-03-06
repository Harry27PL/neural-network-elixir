# Ai

## Przykład użycia

``` elixir
    nn = Ai.NeuralNetwork.start_link 2, [4, 1]
    Ai.NeuralNetwork.calculate nn [0.21, 0.37]
    # [0.1988608357668184]
```
