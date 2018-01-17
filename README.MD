# QuantDSL

QuantDSL is a domain-specific language for quantitative finance. With QuantDSL,  you can define financial contracts using a declarative syntax. Once you have defined a contract, you can use that definition to:

- Price the contract
- Simulate future prices depending a different market scenarios
- In the future,  you will also be able to compose contracts by assembling simpler ones

The typical approach taken by pricing libraries such as QuantLib is to force you to define in great details, and often in a tedious way, the key steps for pricing a financial contract or instrument. For example, see the following [discussion](https://quant.stackexchange.com/questions/21046/why-does-it-take-so-many-lines-of-code-to-price-even-the-simplest-of-options-wit) justifying the reasons behind such complexity. Libraries such as QuantLib try to implement quantitative finance concepts by using a general-purpose language such as C++. In trying to achieve this, concepts such as OOP, inheritance, design patterns and so forth are extensively used. Unfortunately this can very quickly result in a very bloated and over-engineered implementation. The other problem relies in using C++ in the first place. Historically this has been the case because of C++ perceived performance over other languages.

However, we believe that using a general-purpose language to implement a contract pricing library is a flawed approach in the first place. Instead we have taken the DSL approach where a "mini-language" is created in order represent core financial concepts in a flexible way.     

The core principle behind QuantDSL is its declarative nature: you describe the key characteristics of a derivative contract, and then let the QuantDSL runtime figure out how to price it. 

## Compilation

To generate the lexer and parser using antlr run:

```
# it is gradlew.bat on Windows
./gradlew generateGrammarSouce
```

## IntelliJ IDEA Project files

These files can be generated locally by running:

```
# it is gradlew.bat on Windows
./gradlew idea
```

Given they are generated they are not committed.