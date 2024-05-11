class ProjectsController < ApplicationController
  def index
    matching_projects = Project.all

    @list_of_projects = matching_projects.order({ :created_at => :desc })

    render({ :template => "projects/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_projects = Project.where({ :id => the_id })

    @the_project = matching_projects.at(0)

    render({ :template => "projects/show" })
  end

  def create
    the_project = Project.new
    the_project.title = params.fetch("query_title")
    the_project.completed_photo = params.fetch("query_completed_photo")
    the_project.desription = params.fetch("query_desription")
    the_project.status = params.fetch("query_status")
    the_project.start_date = params.fetch("query_start_date")
    the_project.finish_date = params.fetch("query_finish_date")
    the_project.other_notes = params.fetch("query_other_notes")
    the_project.user_id = params.fetch("query_user_id")
    the_project.inspiration_id = params.fetch("query_inspiration_id")
    the_project.artworks_count = params.fetch("query_artworks_count")
    the_project.updates_count = params.fetch("query_updates_count")

    if the_project.valid?
      the_project.save
      redirect_to("/projects", { :notice => "Project created successfully." })
    else
      redirect_to("/projects", { :alert => the_project.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_project = Project.where({ :id => the_id }).at(0)

    the_project.title = params.fetch("query_title")
    the_project.completed_photo = params.fetch("query_completed_photo")
    the_project.desription = params.fetch("query_desription")
    the_project.status = params.fetch("query_status")
    the_project.start_date = params.fetch("query_start_date")
    the_project.finish_date = params.fetch("query_finish_date")
    the_project.other_notes = params.fetch("query_other_notes")
    the_project.user_id = params.fetch("query_user_id")
    the_project.inspiration_id = params.fetch("query_inspiration_id")
    the_project.artworks_count = params.fetch("query_artworks_count")
    the_project.updates_count = params.fetch("query_updates_count")

    if the_project.valid?
      the_project.save
      redirect_to("/projects/#{the_project.id}", { :notice => "Project updated successfully."} )
    else
      redirect_to("/projects/#{the_project.id}", { :alert => the_project.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_project = Project.where({ :id => the_id }).at(0)

    the_project.destroy

    redirect_to("/projects", { :notice => "Project deleted successfully."} )
  end
end
