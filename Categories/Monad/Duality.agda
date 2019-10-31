{-# OPTIONS --without-K --safe #-}

open import Categories.Category

module Categories.Monad.Duality {o ℓ e} (C : Category o ℓ e) where

open import Categories.Functor
open import Categories.NaturalTransformation
open import Categories.Monad
open import Categories.Comonad

private
  module C = Category C
  open C
  open HomReasoning

coMonad⇒Comonad : Monad C.op → Comonad C
coMonad⇒Comonad M = record
    { F         = Functor.op F
    ; ε         = NaturalTransformation.op η
    ; δ         = NaturalTransformation.op μ
    ; assoc     = identityˡ ○ sym M.assoc ○ ∘-resp-≈ˡ identityˡ
    ; identityˡ = sym-assoc ○ M.identityˡ
    ; identityʳ = sym-assoc ○ M.identityʳ
    }
  where module M = Monad M
        open M using (F; η; μ)

Comonad⇒coMonad : Comonad C → Monad C.op
Comonad⇒coMonad M = record
    { F         = Functor.op F
    ; η         = NaturalTransformation.op ε
    ; μ         = NaturalTransformation.op δ
    ; assoc     = ∘-resp-≈ˡ identityˡ ○ sym M.assoc ○ identityˡ
    ; identityˡ = assoc ○ M.identityˡ
    ; identityʳ = assoc ○ M.identityʳ
    }
  where module M = Comonad M
        open M using (F; ε; δ)
