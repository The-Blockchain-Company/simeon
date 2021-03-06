{-# LANGUAGE OverloadedStrings #-}
module Language.Simeon.Examples.EscrowSimpleV2 where

import  Language.Simeon
import  Language.Simeon.Pretty

main :: IO ()
main = putStrLn $ show $ pretty $ contract


{- What does the vanilla contract look like?
  - if Alice and Bob choose
      - and agree: do it
      - and disagree: Carol decides
  - Carol also decides if timeout after one choice has been made;
  - refund if no choices are made.
-}

contract :: Contract

contract = When [Case (Deposit "alice" "alice" price) inner]
                10
                Close

inner :: Contract

inner =
  When [ Case aliceChoice
              (When [ Case bobChoice
                          (If (aliceChosen `ValueEQ` bobChosen)
                             agreement
                             arbitrate) ]
                    60
                    arbitrate),
        Case bobChoice
              (When [ Case aliceChoice
                          (If (aliceChosen `ValueEQ` bobChosen)
                              agreement
                              arbitrate) ]
                    60
                    arbitrate)
        ]
        40
        Close

-- The contract to follow when Alice and Bob have made the same choice.

agreement :: Contract
agreement =
  If
    (isPay aliceChosen)
    (Pay "alice" (Party "bob") price Close)
    Close

-- The contract to follow when Alice and Bob disagree, or if
-- Carol has to intervene after a single choice from Alice or Bob.

arbitrate :: Contract

arbitrate =
  When  [ Case carolRefund Close,
          Case carolPay (Pay "alice" (Party "bob") price Close) ]
        100
        Close

-- Predicate for choices

isPay :: Value -> Observation 

isPay chosen = chosen `ValueEQ` (Constant 0)

-- Names for choices

pay,refund,both :: [Bound]

pay    = [Bound 0 0]
refund = [Bound 1 1]
both   = [Bound 0 1]

-- helper function to build Actions

choiceName :: ChoiceName
choiceName = "choice"

choice :: Party -> [Bound] -> Action

choice party bounds =
  Choice (ChoiceId choiceName party) bounds

-- Name choices according to person making choice and choice made

alicePay, aliceRefund, bobPay, bobRefund, carolPay, carolRefund :: Action

alicePay    = choice "alice" pay
aliceRefund = choice "alice" refund
aliceChoice = choice "alice" both

bobPay    = choice "bob" pay
bobRefund = choice "bob" refund
bobChoice = choice "bob" both

carolPay    = choice "carol" pay
carolRefund = choice "carol" refund
carolChoice = choice "carol" both

-- the values chosen in choices

aliceChosen, bobChosen :: Value

aliceChosen = ChoiceValue (ChoiceId choiceName "alice")
bobChosen   = ChoiceValue (ChoiceId choiceName "bob")

-- Value under escrow

price :: Value
price = Constant 450
