class MovimentacoesController < ApplicationController
  before_action :set_movimentacao, only: %i[ show edit update destroy ]

  # GET /movimentacoes or /movimentacoes.json
  def index
    @movimentacoes = collection.order(created_at: :desc)
    @saldo = collection.calcula_saldo
  end

  # GET /movimentacoes/1 or /movimentacoes/1.json
  def show
  end

  # GET /movimentacoes/new
  def new
    @movimentacao = collection.new
  end

  # GET /movimentacoes/1/edit
  def edit
  end

  # POST /movimentacoes or /movimentacoes.json
  def create
    @movimentacao = collection.new(movimentacao_params)

    respond_to do |format|
      if @movimentacao.save
        format.html { redirect_to movimentacao_url(@movimentacao), notice: "Movimentacao was successfully created." }
        format.json { render :show, status: :created, location: @movimentacao }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movimentacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movimentacoes/1 or /movimentacoes/1.json
  def update
    respond_to do |format|
      if @movimentacao.update(movimentacao_params)
        format.html { redirect_to movimentacao_url(@movimentacao), notice: "Movimentacao was successfully updated." }
        format.json { render :show, status: :ok, location: @movimentacao }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movimentacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movimentacoes/1 or /movimentacoes/1.json
  def destroy
    @movimentacao.destroy!

    respond_to do |format|
      format.html { redirect_to movimentacoes_url, notice: "Movimentacao was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def collection
      current_usuario.movimentacoes
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_movimentacao
      @movimentacao = collection.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movimentacao_params
      params.require(:movimentacao).permit(:data, :descricao, :valor, :tipo)
    end
end
