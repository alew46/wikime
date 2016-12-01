class CollaboratorsController < ApplicationController
  before_action :find_wiki
  def create
    @collaborator = @wiki.collaborators.new(user_id: params[:user_id])

    if @collaborator.save
      flash[:notice] = "Collaborator successfully added!"
      redirect_to wiki_collaborators_path(@wiki)
    else
      flash[:alert] = "There was an issue adding this collaborator. Please try again."
      redirect_to wiki_collaborators_path(@wiki)
    end
  end

  def destroy
    @collaborator = @wiki.collaborators.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator successfully removed!"
      redirect_to wiki_collaborators_path(@wiki)
    else
      flash[:alert] = "There was an issue removing this collaborator. Please try again."
      redirect_to wiki_collaborators_path(@wiki)
    end
  end

  def index
    @users = User.all
  end

  private
  def find_wiki
    @wiki = current_user.wikis.find(params[:wiki_id])
  end

end
