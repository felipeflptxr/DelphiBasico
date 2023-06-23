unit Enumerados;

interface

type
  TTipoFormatacaoValor = (tfvPontoDecimal, tfvVirgulaDecimal, tfvVirgulaDecimalPontoMilhar, tfvSemPontoSemVirgula);
  TTipoAlinhamentoCaracterFormatacao = (tacfEsquerda, tacfDireita);
  TUsuarioStatus = (usAtivo, usInativo, usTemporariamenteBloqueado, usBloqueado);
  TStatusProcesso = (spNenhum, spInserindo, spAlterando, spClonando);

implementation

end.
