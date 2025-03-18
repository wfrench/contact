class ContactController < ActionController::API
  def add
    contact = Contact.new
    contact.name = params.require(:name)
    contact.email = params.require(:email)
    contact.save!

    render json: { reponse: "OK" }
  end

  def delete
    Contact.find_by(email: params.require(:email))&.destory
    render json: { reponse: "OK" }
  end

  def search
    render json: { data: Contact.search(params.require(:name)) }
  end
end
