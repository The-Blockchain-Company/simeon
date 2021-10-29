{-# LANGUAGE OverloadedStrings #-}
module Language.Simeon.Examples.EscrowSimple where

import           Language.Simeon

{- What does the vanilla contract look like?
   Using layout for scoping here

When
  bobClaims
    when
      carolAgrees
        Pay "alice" "bob" bcc price
      carolDisagrees
        Close "alice"
  aliceClaims
    when
      carolAgrees
        Close "alice"
      carolDisagrees
        Pay "alice" "bob" bcc price

-}

contract :: Contract
contract = When [Case (Deposit "alice" "alice" bcc price)
                      (When [ processBobClaim
                            , processAliceClaim
                            ]
                            90
                            Close)
                ]
                10
                Close

processBobClaim, processAliceClaim :: Case

processBobClaim =
  Case bobClaims
    (When [ Case carolAgrees (Pay "alice" (Party "bob") bcc price Close)
          , Case carolDisagrees Close
          ]
         100
         Close)

processAliceClaim =
  Case aliceClaims
    (When [ Case carolAgrees Close,
            Case carolDisagrees (Pay "alice" (Party "bob") bcc price Close)
          ]
       100
       Close)

aliceClaims, bobClaims, carolAgrees, carolDisagrees :: Action

aliceClaims    = Choice (ChoiceId "claim" "alice") [Bound 0 0]
bobClaims      = Choice (ChoiceId "claim" "bob")   [Bound 0 0]
carolAgrees    = Choice (ChoiceId "agree" "carol") [Bound 0 0]
carolDisagrees = Choice (ChoiceId "agree" "carol") [Bound 1 1]


-- Value under escrow
price :: Value
price = Constant 450
