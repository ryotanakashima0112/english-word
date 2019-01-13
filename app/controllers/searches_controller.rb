class SearchesController < ApplicationController
  def search_english
    @vocabularies = Vocabulary.search_english(params[:search])
    render :search_english
  end

  def search_japanies
    @vocabularies = Vocabulary.search_japanies(params[:search])
    render :search_japanies
  end
end