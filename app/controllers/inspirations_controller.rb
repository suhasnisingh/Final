class InspirationsController < ApplicationController
  def index
    matching_inspirations = Inspiration.all

    @list_of_inspirations = matching_inspirations.order({ :created_at => :desc })

    render({ :template => "inspirations/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_inspirations = Inspiration.where({ :id => the_id })

    @the_inspiration = matching_inspirations.at(0)

    render({ :template => "inspirations/show" })
  end

  def create
    the_inspiration = Inspiration.new
    the_inspiration.name = params.fetch("query_name")
    the_inspiration.description = params.fetch("query_description")
    the_inspiration.other_notes = params.fetch("query_other_notes")
    the_inspiration.user_id = params.fetch("query_user_id")
    the_inspiration.visibility = params.fetch("query_visibility", false)
    the_inspiration.projects_count = params.fetch("query_projects_count")
    the_inspiration.artists_count = params.fetch("query_artists_count")
    the_inspiration.artworks_count = params.fetch("query_artworks_count")

    if the_inspiration.valid?
      the_inspiration.save
      redirect_to("/inspirations", { :notice => "Inspiration created successfully." })
    else
      redirect_to("/inspirations", { :alert => the_inspiration.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_inspiration = Inspiration.where({ :id => the_id }).at(0)

    the_inspiration.name = params.fetch("query_name")
    the_inspiration.description = params.fetch("query_description")
    the_inspiration.other_notes = params.fetch("query_other_notes")
    the_inspiration.user_id = params.fetch("query_user_id")
    the_inspiration.visibility = params.fetch("query_visibility", false)
    the_inspiration.projects_count = params.fetch("query_projects_count")
    the_inspiration.artists_count = params.fetch("query_artists_count")
    the_inspiration.artworks_count = params.fetch("query_artworks_count")

    if the_inspiration.valid?
      the_inspiration.save
      redirect_to("/inspirations/#{the_inspiration.id}", { :notice => "Inspiration updated successfully."} )
    else
      redirect_to("/inspirations/#{the_inspiration.id}", { :alert => the_inspiration.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_inspiration = Inspiration.where({ :id => the_id }).at(0)

    the_inspiration.destroy

    redirect_to("/inspirations", { :notice => "Inspiration deleted successfully."} )
  end
end
