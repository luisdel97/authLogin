class NotesController < ApplicationController
  before_action :set_note, only: [:show, :update, :destroy]
  before_action :authorized

  # GET /notes
  def index
    @notes = Note.where(user_id: @user.id)

    render json: @notes
  end

  # GET /notes/1
  def show
    render json: @note
  end

  # GET /notes/new
  # def new
  #   @note = Note.new
  # end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes or /notes.json
  def create
    @note = Note.new(note_params)
    @note.user_id = @user.id

    if @note.save
      render json: @note, status: :created, location: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    if @note.update(note_params)
      render json: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:message, :user_id)
    end
end
