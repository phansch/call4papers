class Admin::PapersController < Admin::AdminController
  def index
    @papers = Paper.order('selected DESC, track ASC, time_slot ASC, created_at DESC')
  end

  def export
    @papers = Paper.order('selected DESC, track ASC, time_slot ASC, created_at DESC')

    respond_to do |format|
      format.csv do
        csv_response = build_csv(@papers, export_columns)
        send_data(csv_response, filename: 'papers.csv', disposition: 'attachment', type: 'text/csv; charset=utf-8; header=present')
      end
    end
  end

  private

  def export_columns
    # Handle call_id, user_id (when deanonymized)
    %w(
      id
      title
      public_description
      private_description
      selected
      time_slot
      track
      created_at
      updated_at
    )
  end

end
