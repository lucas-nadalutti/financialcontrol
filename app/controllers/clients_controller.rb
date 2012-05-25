#encoding: utf-8

class ClientsController < ApplicationController
	helper_method :table_arranging
	helper_method :transactions_report
	helper_method :calculate_percentage
	helper_method :round_to_two_decimals

	def table_arranging
		@client = Client.find(params[:id])
		spec = params[:spec]
		if spec
			return @client.transactions.where(["YEAR(datetime) = ? AND MONTH(datetime) = ?", spec[:year], spec[:month]])
		else
			return nil
		end
	end

	def transactions_report
		@client = Client.find(params[:id])
		from = params[:old]
		values = params[:values]
		if from
			to = params[:new]
			beggining = DateTime.new(from[:year].to_i, from[:month].to_i, from[:day].to_i, from[:hours].to_i, from[:minutes].to_i)
			ending = DateTime.new(to[:year].to_i, to[:month].to_i, to[:day].to_i, to[:hours].to_i, to[:minutes].to_i)
			return @client.transactions.where(["datetime >= ? AND datetime <= ?", beggining, ending])
		elsif values
			return @client.transactions.where(["value >= ? AND value <= ?", values[:min].to_f, values[:max].to_f])
		else
			category = Category.where(["name = ?", params[:category_name].tr("*", " ")]).first
			return @client.transactions.where(["category_id = ?", category.id])
		end
	end

	def calculate_percentage(x, y)
		total = x + y
		return (x.to_f/total)*100
	end

	def round_to_two_decimals(n)
		return (n*100).to_i/100.0
	end

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.find(params[:id])
  end

  # GET /clients/new
  # GET /clients/new.json
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(params[:client])
		@client.logged = false
    if @client.save
      redirect_to signup_clients_path, notice: 'Client was successfully created!'
    else
      render action: "new"
    end
  end

  # PUT /clients/1
  # PUT /clients/1.json
  def update
    @client = Client.find(params[:id])		
    if @client.update_attributes(params[:client])
      redirect_to @client, notice: 'Client was successfully updated!'
    else
      render action: "edit"
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to clients_url
  end

	def signup
	end

	def login
		in_client = params[:in_client]
		@client = Client.where(["email = ?", in_client[:email]]).first
		if @client
			if in_client[:password] == @client.password
				@client.logged = true
				@client.save
				redirect_to @client, notice: 'Logged successfully!'
			else
				redirect_to signup_clients_path, notice: 'Wrong password!'
			end
		else
			redirect_to signup_clients_path, notice: 'This e-mail is not registered!'
		end
	end

	def logout
		@client = Client.find(params[:id])
		@client.logged = false
		@client.save
		redirect_to clients_path, notice: 'Succesfully logged out!'
	end

	def change_pw
		@client = Client.find(params[:id])
		if !@client.logged
			redirect_to @client, notice: 'Not logged in!'
		end
	end

  def change
    @client = Client.find(params[:id])
		passwords = params[:pw]
		if @client.password == passwords[:old] && passwords[:new] == passwords[:confirm]
		  @client.password = passwords[:new]
			if @client.save
		  	redirect_to @client, notice: 'Password was successfully changed!'
			else
				render action: "change_pw"
			end
		else
			redirect_to @client, notice: 'Wrong password was given!'
		end
  end

	def trans
		@client = Client.find(params[:id])
		if !@client.logged
			redirect_to @client, notice: 'Not logged in!'
		end
	end

	def report
		@client = Client.find(params[:id])
	end

	def specific_t
    @client = Client.find(params[:id])
	end

	def specific_period
    @client = Client.find(params[:id])
	end

	def specific_values
    @client = Client.find(params[:id])
	end

	def specific_category
    @client = Client.find(params[:id])
	end

end
