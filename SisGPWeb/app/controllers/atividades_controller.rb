class AtividadesController < ApplicationController
  before_action :set_atividade, only: [:show, :edit, :update, :destroy]

  # GET /atividades
  # GET /atividades.json
  def index
    @atividades = Atividade.all
  end

  # GET /atividades/1
  # GET /atividades/1.json
  def show
  end

  # GET /atividades/new
  def new
    @atividade = Atividade.new
    @processo = Processo.find(params[:id])
  end

  # GET /atividades/1/edit
  def edit
  end

  # POST /atividades
  # POST /atividades.json
  def create

    @atividade = Atividade.new(atividade_params)
    responsavel_to_be_added_email = params[:responsavel]
    @responsavel_to_be_added = Usuario.where(:email => responsavel_to_be_added_email).first
    @atividade.adicionar_responsavel (@responsavel_to_be_added.id)

    respond_to do |format|
      if @atividade.save
        format.html { redirect_to root_path, notice: 'Atividade '+ @atividade.nome + ' criada com sucesso' }
        format.json { render :show, status: :created, location: @atividade }
      else
        format.html { render :new }
        format.json { render json: @atividade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /atividades/1
  # PATCH/PUT /atividades/1.json
  def update
    respond_to do |format|
      if @atividade.update(atividade_params)
        format.html { redirect_to @atividade, notice: 'Atividade was successfully updated.' }
        format.json { render :show, status: :ok, location: @atividade }
      else
        format.html { render :edit }
        format.json { render json: @atividade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /atividades/1
  # DELETE /atividades/1.json
  def destroy
    @atividade.destroy
    respond_to do |format|
      format.html { redirect_to atividades_url, notice: 'Atividade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_atividade
      @atividade = Atividade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def atividade_params
     params.require(:atividade).permit(:nome, :descricao, :dataInicio, :dataFim, :processo_id)
    end
end
