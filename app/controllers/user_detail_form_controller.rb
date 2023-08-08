class UserDetailFormController < ApplicationController
   
    # def first_form
    #     @first_form = Firstform.new(session[:first_form] || {})
    # end
    
    # def create_first_form
    #   @first_form = FirstForm.new(first_form_params)
    #   if @first_form.valid?
    #     session[:first_form] = @first_form.attributes
    #     redirect_to second_form_path
    #   else
    #     render :first_form # Assuming you have a view named 'new_first_form.html.erb'
    #   end
    # end
      
    # private
    # def first_form_params
    #   params.require(:first_form).permit(
    #     :firstname, :midname, :lastname, :age, :dob, :email, :phone_no,
    #     :occupation, :degree, :organization, :experience, :org_address,
    #     :about_us, :interest_rating, :course, :instagram_account, :twitter_account, :facebook_account,
    #     :cgpa, :father_name, :mother_name, :father_mobile, :mother_mobile, :sibling_details, :suggestions
    #   )
    # end
  
end
