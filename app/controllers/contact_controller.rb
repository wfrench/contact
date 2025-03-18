class ContactController < ActionController::API
  def add
    contact = Contact.new
    contact.name = params.require(:name)
    contact.email = params.require(:email)
    contact.save!

    render json: { reponse: "OK" }
  end

  def delete
    params.require(:email)
    Contact.find_by(email: params[:email])&.destory
    render json: { reponse: "OK" }
  end

  def search
    params.require(:name)
    render json: { data: Contact.where("name LIKE ?", "%#{params.require(:name)}%") }
  end
end
