# Introducing Simeon

This tutorial gives an overview of the ideas behind Simeon, as a domain-specific language embedded in Haskell. It also introduces commitments and timeouts, which are central to how Simeon works in a blockchain context. 

## Programming Languages and Domain-Specific Languages

The first computers were programmed in “machine code”. Each kind of system had a different code, and these codes were low-level and inexpressive: programs were long sequences of very simple instructions, incomprehensible to anyone who had not written them. Nowadays we are able to use higher-level languages like C, Java and Haskell to program systems. The same languages can be used on widely different machines, and the structure of the programs reflects what they do. On blockchain, their equivalents are languages like Zerepoch, Solidity and Simplicity. These higher-level languages are general purpose – they can be used to solve all sorts of different problems – but the solutions they express are still programs, and they still require programming skills to use them effectively.

In contrast, Simeon is a domain-specific language (DSL) which is designed to be usable by someone who is expert in a particular field, rather than requiring programming skills to use it. In the case of Simeon, the domain is the field of financial contracts.  

Using a DSL has many advantages beyond its use by non-programmers:

- We can ensure that certain sorts of bad programs cannot even be written, by designing those possibilities out of the language. By doing this we can aim to avoid some of the unanticipated exploits which have been a problem for existing blockchains.

- We can also more easily check that programs have the properties that we want: for example, in the case of a financial contract, we might want to make sure that the contract can never fail to make a payment that it should.

- Because it is a DSL, we can build special-purpose tools to help people write programs in the language. In the case of Simeon we can emulate how a contract will behave before it is run for real on the blockchain; this helps us to make sure that the contract we have written is doing what it is intended to.

Simeon is also an _embedded_ DSL, hosted in the [Haskell](https://www.haskell.org) programming language. While it is possible to use “pure” Simeon if we wish, being embedded in a general-purpose language allows contract writers to selectively exploit features of Haskell in writing Simeon contracts, making them easier to read, supporting re-use and so forth.

## Simeon in a nutshell

Simeon is modelled on financial contract DSLs popularised in the last decade or so by academics and enterprises such as LexiFi, which provides contract software in the financial sector. In developing Simeon, we have adapted these languages to work on blockchain. Simeon is implemented on the settlement layer (SL) of the Bcc blockchain, but could equally well be implemented on Ethereum/Solidity or other blockchain platforms; in this respect it is “platform agnostic” just like modern programming languages like Java and C++. The Simeon Playground online emulator tool allows you to experiment with, develop and interact with Simeon contracts in your web browser, without having to install any software.

What does a Simeon contract look like? It is built by combining a small number of building blocks that describe making a payment, making an observation of something in the “real world”, waiting until a certain condition becomes true, and so on. 

## Commitments and timeouts

Where we differ from non-blockchain approaches is in how we make sure that the contract is followed. This means not only that the instructions of the contract are not disobeyed (_“nothing bad happens”_), but also that the participants participate and don’t walk away early, leaving money locked up in the contract forever (_“good things actually happen”_). We do this using two concepts: commitments and timeouts.

A __commitment__ requires participants to “put their money on the table” – more formally, to commit an amount of currency to the contract – and so to lock it up there for a certain period of time that is known in advance. If some or all of the currency remains in the contract at the end of the commitment period, then it can be reclaimed by the participant.

In our model, a running contract cannot force a payment or a commitment to happen: all it can do is to request a commitment from a participant, or to allow a payment to take place. In other words it cannot “_push_”, but it can “_pull_”. How then can we deal with the situation in which a request to make a payment or to make a commitment is not acted upon? Using __timeouts__ we can make sure that if a commitment does not happen in a timely manner then remedial action will be taken. This, in turn, ensures that contract execution will eventually progress, whether ot not contract participants choose to engage. 

## Simeon in action

We are working on a production release of Simeon on the Bcc blockchain later this year (2019). From today, you are able to explore Simeon for yourself, either by downloading it and using the Haskell implementation directly, or by using the online Simeon Playground simulation tool; these are both covered in subsequent tutorials. These will also cover the details of Simeon, introduce a series of examples, look deeper into the tools for Simeon. 

In the next six months we will be polishing the language design itself and developing a set of templates for popular financial instruments, as well as using formal logic tools to prove properties of Simeon contracts, giving users the highest level of assurance that their contracts behave as intended.



## Where to go to find out more 

This tutorial covers the latest version of Simeon, while all but the first of these links covers Simeon 1.3, which is very close to Simeon 2.0 in conception but which differs in a number of detailed ways. See **ADD LINK** for details.

- The Simeon github repository: [link](https://github.com/The-Blockchain-Company/simeon)
- The Simeon paper: [link](https://kar.kent.ac.uk/69846/)
- Simeon video from ZerepochFest, December 2018: [link](https://www.youtube.com/watch?v=rSpFOADHLqw)
- Simeon video from Coinscrum, London, March 2019: [link to be added]()

### [Up](./README.md) [Next](./escrow-ex.md)