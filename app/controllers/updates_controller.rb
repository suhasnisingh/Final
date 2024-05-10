class UpdatesController < ApplicationController
  def index
    matching_updates = Update.all

    @list_of_updates = matching_updates.order({ :created_at => :desc })

    render({ :template => "updates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_updates = Update.where({ :id => the_id })

    @the_update = matching_updates.at(0)

    render({ :template => "updates/show" })
  end

  def create
    the_update = Update.new
    the_update.photo = params.fetch("query_photo")
    the_update.body = params.fetch("query_body")
    the_update.project_id = params.fetch("query_project_id")

    if the_update.valid?
      the_update.save
      redirect_to("/updates", { :notice => "Update created successfully." })
    else
      redirect_to("/updates", { :alert => the_update.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_update = Update.where({ :id => the_id }).at(0)

    the_update.photo = params.fetch("query_photo")
    the_update.body = params.fetch("query_body")
    the_update.project_id = params.fetch("query_project_id")

    if the_update.valid?
      the_update.save
      redirect_to("/updates/#{the_update.id}", { :notice => "Update updated successfully."} )
    else
      redirect_to("/updates/#{the_update.id}", { :alert => the_update.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_update = Update.where({ :id => the_id }).at(0)

    the_update.destroy

    redirect_to("/updates", { :notice => "Update deleted successfully."} )
  end
end
