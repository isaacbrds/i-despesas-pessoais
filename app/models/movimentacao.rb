class Movimentacao < ApplicationRecord
  enum :tipo, {saida: 'saida', entrada: 'entrada'}

  belongs_to :usuario

  validates :tipo, :valor, presence: true
  validates :data, comparison: {less_than_or_equal_to: proc { Date.current }}
  validate :valida_se_existe_saldo, if: -> { self.saida? }

  def self.calcula_saldo
    self.entrada.sum(:valor) - self.saida.sum(:valor)
  end

  private

  def valida_se_existe_saldo
    return unless usuario
    
    if valor.to_f > Movimentacao.calcula_saldo
      errors.add :valor, 'Não há saldo suficiente'
    end
  end
end
