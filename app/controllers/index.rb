#Metodo que verifica antes de que el usuario entre
before '/users/:id' do
  session[:id]
  unless session[:id]
    redirect to('/login')
  end 
end

#Ruta para terminar sesion
get '/logout' do
  session.clear
  redirect to("/")
end

#Metodo de inicio que lleva a la pantalla de inicio
get "/" do
  erb :welcome
end

#Metodo que me da todas mis preguntas
get '/my_questions' do
  user_id = session[:id]
  @questions = User.find_by(id: user_id).questions
  erb :myquestions
end

#Metodo que me da todas mis respuestas
get '/my_answers' do
  user_id = session[:id]
  @answers = User.find_by(id: user_id).answers
  erb :myanswers
end

#Metodo que lleva al perfil del usuario y ver sus datos
get "/user_profile" do
  @current_user = session[:id]
  erb :user_profile
end


get '/:url' do
  url = params[:url]
  if url == "register"
    erb :register
  elsif url == "login"
    erb :login
  end
end

#MEtodo que lleva al index con su id como parametro
get '/users/:id' do
  erb :index
end

#Crear un voto positivo
post '/positive_vote/' do
  question_id = params["id_vote"]
  question_id = question_id.to_i
  VoteQuestion.create(question_id: question_id, type_vote: "true");
  redirect to ("/users/#{session[:id]}")
end

#Crear un voto negativo
post '/negative_vote/' do
  question_id = params["id_vote"]
  question_id = question_id.to_i
  VoteQuestion.create(question_id: question_id,type_vote: "false");
  redirect to ("/users/#{session[:id]}")
end


#Metodo que registra a un usuario
post '/register' do

  user = User.new(user_name: params[:user_name], email: params[:user_email], password: params[:user_password])

  if user.save
    session[:id] = user.id
    redirect to ("/users/#{user.id}")
  else
    @message_error = "El correo que ingreso ya fue registrado"
    erb :register    
  end
end

#Metodo que hace login de un usuario

post '/login' do
  user = User.authenticate(params[:user_email], params[:user_password])
  if user
    session[:id] = user.id
    redirect to ("/users/#{user.id}")
  else
    @message_error = "La contraseña no es correcta o su usuario no ha sido registrado"
    erb :login
  end
end

#Crea una pregunta
post '/create_question' do
  Question.create(user_id: session[:id], question_text: params[:question_user])
  redirect to ("/users/#{session[:id]}")
end

#Metodo que agrega una respuesta

post '/add_answer/:id_question' do
  question_id = params[:id_question]
  Answer.create(question_id: question_id, user_id: session[:id], answer_text: params[:answer])
  redirect to ("/users/#{session[:id]}")
end
