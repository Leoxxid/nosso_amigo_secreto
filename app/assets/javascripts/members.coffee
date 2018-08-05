$(document).on 'turbolinks:load', ->
  $('#member_email, #member_name').keypress (e) ->
    if e.which == 13 && valid_email($( "#member_email" ).val()) && $( "#member_name" ).val() != ""
      $('.new_member').submit()

  $('#member_email, #member_name').bind 'blur', ->
    if valid_email($( "#member_email" ).val()) && $( "#member_name" ).val() != ""
      $('.new_member').submit()

  $('body').on 'click', 'a.remove_member', (e) ->
    $.ajax '/members/'+ e.currentTarget.id,
        type: 'DELETE'
        dataType: 'json',
        data: {}
        success: (data, text, jqXHR) ->
          Materialize.toast('Membro removido', 4000, 'green')
          $('#member_' + e.currentTarget.id).remove()
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problema na remoção de membro', 4000, 'red')
    return false

  $('.new_member').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'POST'
        dataType: 'json',
        data: $(".new_member").serialize()
        success: (data, text, jqXHR) ->
          insert_member(data['id'], data['name'],  data['email'])
          $('#member_name, #member_email').val("")
          $('#member_name').focus()
          Materialize.toast('Membro adicionado', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problema na hora de incluir membro', 4000, 'red')
    return false

  $('.edit_member input').on 'blur', ->
    $(this).closest('form').submit()

  $('.edit_member').on 'submit', (e) ->
    remote_update_member(e)

  $(document).ready ->
    $('.modal').modal()

valid_email = (email) ->
  /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(email)

insert_member = (id, name, email) ->
  $('.member_list').append(
    '<form class="edit_member" id="edit_member_' + id + '" ' +
    'action="/members/' + id + '" method="POST" accept-charset="UTF-8" >' +
      '<input name="utf8" type="hidden" value="✓" />' +
      '<input type="hidden" name="_method" value="put" />'+
      '<div class="member" id="member_' + id + '">' +
        '<div class="row">' +
          '<div class="col s12 m5 input-field">' +
            '<input id="name" name="member[name]" type="text" class="validate" value="' + name + '">' +
            '<label for="name" class="active">Nome</label>' +
          '</div>' +
          '<div class="col s12 m5 input-field">' +
            '<input id="email" name="member[email]" type="email" class="validate" value="' + email + '">' +
            '<label for="email" class="active" data-error="Formato incorreto">Email</label>' +
          '</div>' +
          '<div class="col s3 offset-s3 m1 input-field">' +
            '<i class="material-icons icon">visibility</i>' +
          '</div>' +
          '<div class="col s3 m1 input-field">' +
            '<a class="modal-trigger" href="#modal-member-' + id + '">' +
              '<i class="material-icons icon">delete</i>' +
            '</a>' +
            '<div id="modal-member-' + id + '" class="modal">' +
              '<div class="modal-content">' +
                '<h4>Atenção</h4>' +
                '<p>Você realmente deseja excluir "' + name + '" do amigo secreto?</p>' +
              '</div>' +
              '<div class="modal-footer">' +
                '<a class="modal-close waves-effect waves-red btn-flat">' +
                  'Cancelar' +
                '</a>' +
                '<a class="modal-close waves-effect waves-green btn-flat remove_member" id="' + id + '">' +
                  'Confirmar' +
                '</a>' +
              '</div>' +
            '</div>' +
          '</div>' +
        '</div>' +
      '</div>' +
    '</form>')

  $('#modal-member-' + id ).modal()

  $('#edit_member_' + id + ' input').on 'blur', ->
    $(this).closest('form').submit()

  $('#edit_member_' + id ).on 'submit', (e) ->
    remote_update_member(e)

remote_update_member = (e) ->
  $.ajax e.target.action,
    type: 'PUT'
    dataType: 'json',
    data: $(e.currentTarget).serialize()
    success: (data, text, jqXHR) ->
      Materialize.toast('Membro atualizado', 4000, 'green')
    error: (jqXHR, textStatus, errorThrown) ->
      console.log jqXHR
      Materialize.toast('Problema na atualização do membro', 4000, 'red')
      return false

  e.preventDefault()
