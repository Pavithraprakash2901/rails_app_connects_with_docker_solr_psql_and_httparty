class PagesController < ApplicationController

  before_action :authenticate_user!

  
  def home 
    def search_bar
      if params[:query].present?
        @result = search(params[:query])
      else
        @result = []
      end
    end  
  end   

  def user_detail_form
    @user_detail_form = UserDetailForm.new(session[:user_detail_form] || {})
  end

  def create_user_detail_form
    puts "i am here"
    @user_detail_form = UserDetailForm.new(pavi_forms)
    if @user_detail_form.valid?
      session[:user_detail_form] = @user_detail_form.attributes
      redirect_to second_form_path
    else
      render :user_detail_form
    end
  end
  
  
  def second_form
    @second_form = SecondForm.new(session[:second_form] || {})
  end  

  def create_second_form
   
    @second_form = SecondForm.new(second_form_params)
    if @second_form.valid?
      # Handle successful form submission here, such as redirection or rendering another view
      session[:second_form] = @second_form.attributes
      redirect_to third_form_path
    else
      render :second_form
    end
  end   

  def third_form
    @third_form= ThirdForm.new(session[:third_form]|| {}) 
    
  end   
 
  # def create_third_form
  #   puts "Hello"
  #   # puts params.inspect
  #   @first_form = FirstForm.new(session[:first_form] || {})
  #   @second_form = SecondForm.new(session[:second_form] || {})
  #   @third_form = ThirdForm.new(third_form_params)
  #   if @third_form.valid?
  #     puts "hi"
  #     if @first_form.save && @second_form.save && @third_form.save
  #       puts "saved successfully"
  #     end 
  #     p @third_form.inspect
    
  #   else
  #     render :new
  #   end
  # end

  def create_third_form
    @user_detail_form = UserDetail.new(session[:user_detail_form] || {})
    @second_form = SecondForm.new(session[:second_form] || {})
    @third_form = ThirdForm.new(lastform)
    puts "hello"

    # if @third_form.valid?
    # @first_form.save
    # @second_form.save
    # @third_form.save
    
    if @user_detail_form.save && @second_form.save && @third_form.save
      solr = RSolr.connect(url: 'http://localhost:8983/solr/ums')
      solr.add([
        @user_detail.attributes.merge(id: @user_detail.id),  
        @second_form.attributes.merge(id: @second_form.id), 
        @third_form.attributes.merge(id: @third_form.id)
          ])
      solr.commit

      session[:user_detail_form]= nil
      session[:second_form]= nil
      session[:third_form]= nil


        redirect_to thankyou_path
      puts "saved successfully"
     end     
  #  end  
  end  


  def success
  end  



   
  private

  def pavi_forms
    params.require(:user_detail_form).permit(
    :firstname, :midname, :lastname, :age, :dob, :email, :phone_no,
    :occupation, :degree, :organization, :experience, :org_address,
    :about_us, :interest_rating, :course, :instagram_account, :twitter_account, :facebook_account,
    :cgpa, :father_name, :mother_name, :father_mobile, :mother_mobile, :sibling_details, :suggestions
    )
  end


  def second_form_params
    params.require(:second_form).permit(
    :name, :phone, :mail,
    :temp_door_no, :temp_street_name, :temp_landmark, :temp_post, :temp_district, :temp_state, :temp_pincode,
    :perm_door_no, :perm_street_name, :perm_landmark, :perm_post, :perm_district, :perm_state, :perm_pincode,
    :ref_name, :ref_contact, :ref_mail
    )
  end
  
  def lastform
    params.require(:third_form).permit(
      :name, :email, :phone_no, :tenth_mark, :twelfth_mark,
      :cgpa, :aadhar_no, :pan_no, :account_no, :no_of_siblings, 
      :first_graduate, :skills, :differently_abled, :completed_graduation
    )
  end

  def search(query)
    solr = RSolr.connect(url: 'http://localhost:8983/solr/ums')
    response = solr.get('select', params: { q:query})
    puts q:query
    results = response['response']['docs']
    puts results
    return results
   rescue RSolr::Error::ConnectionRefused => e
    return []
  end
end

