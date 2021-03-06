class VocabulariesController < ApplicationController
  before_action :set_vocabulary, only: [:show, :edit, :update, :destroy]

  # GET /vocabularies
  # GET /vocabularies.json
  def index
    @vocabularies = Vocabulary.page(params[:page]).per(10)
  end


  def new
    @vocabulary = Vocabulary.new
  end

  # GET /vocabularies/1/edit
  def edit
  end

  # POST /vocabularies
  # POST /vocabularies.json
  def create
    @vocabulary = Vocabulary.new(vocabulary_params)

    respond_to do |format|
      if @vocabulary.save
        flash[:success] = '新しい単語を登録しました。'
        format.html { redirect_to @vocabulary}
        format.json { render :show, status: :created, location: @vocabulary }
      else
        flash.now[:danger] = '単語の登録に失敗しました。'
        format.html { render :new }
        format.json { render json: @vocabulary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vocabularies/1
  # PATCH/PUT /vocabularies/1.json
  def update
    respond_to do |format|
      if @vocabulary.update(vocabulary_params)
        flash[:success] = '単語の編集に成功しました。'
        format.html { redirect_to @vocabulary}
        format.json { render :show, status: :ok, location: @vocabulary }
      else
        flash.now[:danger] = '単語の編集に失敗しました。'
        format.html { render :edit }
        format.json { render json: @vocabulary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vocabularies/1
  # DELETE /vocabularies/1.json
  def destroy
    @vocabulary.destroy
    flash[:success] = '単語を削除しました。'
    respond_to do |format|
      format.html { redirect_to vocabularies_url }
      format.json { head :no_content }
    end
  end

  def english_to_japanies_mode
    @vocabulary = Vocabulary.where( 'id >= ?', rand(Vocabulary.count) + 1 ).first
    @word = @vocabulary.word
    render :english_to_japanies_mode
  end

  def japanies_to_english_mode
    @meaning = Vocabulary.where( 'id >= ?', rand(Vocabulary.count) + 1 ).first.meaning
    render :japanies_to_english_mode
  end

  def mistake_english
    @vocabulary = Vocabulary.find_by(word: params[:vocabulary][:word])

    if @vocabulary.count == nil
      @vocabulary.count = 0
      @vocabulary.count += 1
    else
      @vocabulary.count += 1
    end

    flash.now[:danger] = "#{@vocabulary.word}の間違えた回数が#{@vocabulary.count}回になりました！"

    @vocabulary.save

    @word = Vocabulary.where( 'id >= ?', rand(Vocabulary.count) + 1 ).first.word
    render :english_to_japanies_mode
  end

  def mistake_japanies
    @vocabulary = Vocabulary.find_by(meaning: params[:vocabulary][:meaning])
    if @vocabulary.count == nil
      @vocabulary.count = 0
      @vocabulary.count += 1
    else
      @vocabulary.count += 1
    end

    flash.now[:danger] = "#{@vocabulary.word}の間違えた回数が#{@vocabulary.count}回になりました！"

    @vocabulary.save

    @meaning = Vocabulary.where( 'id >= ?', rand(Vocabulary.count) + 1 ).first.meaning
    render :japanies_to_english_mode
  end

  def english_word_test
    @words = []
    10.times do
      @words << Vocabulary.where( 'id >= ?', rand(Vocabulary.count) + 1 ).first.word
    end
    render :english_word_test
  end

  def japanies_meaning_test
    @meanings = []
    10.times do
      @meanings << Vocabulary.where( 'id >= ?', rand(Vocabulary.count) + 1 ).first.meaning
    end
    render :japanies_meaning_test
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vocabulary
      @vocabulary = Vocabulary.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vocabulary_params
      params.require(:vocabulary).permit(:word, :meaning, :count)
    end
end
