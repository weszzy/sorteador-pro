# Contribuindo

Obrigado pelo interesse em contribuir com o Sorteador Pro.

## Antes de abrir PR

1. Abra ou comente uma issue explicando o problema.
2. Crie uma branch descritiva.
3. Rode validações locais.
4. Inclua screenshots quando houver mudança visual.

## Comandos

```bash
flutter pub get
flutter analyze
flutter test
```

## Padrões

- Preserve a separação entre `core`, `data`, `domain` e `presentation`.
- Regras de sorteio ficam em use cases, não em widgets.
- Widgets devem ser focados e pequenos o suficiente para revisão.
- Evite dependências novas sem justificativa clara.
- Mudança em regra de negócio precisa de teste.

## UX/UI

- A tela deve ter uma ação primária clara.
- Estados vazio, erro e sucesso precisam ter texto útil.
- Área tocável mínima deve ser confortável em mobile.
- Evite blur, sombra pesada e animação em áreas roláveis.

## Segurança

Nunca envie:

- `.env` real.
- Keystore, `.jks`, `.p12` ou senha de assinatura.
- Tokens, API keys ou credenciais.
- Arquivos internos de agente ou análise local.
