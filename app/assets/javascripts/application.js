// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require tether
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

$(document).ready(function () {
    var counter = 0;

    $("#addrow").on("click", function () {
        var newRow = $("<tr>");
        var cols = "";

        cols += '<td class="col-sm-5"><input type="text" class="form-control" placeholder="Ticket Type Name" name="ticket_types[' + counter + ']name"/></td>';
        cols += '<td class="col-sm-3"><input type="text" class="form-control" placeholder="Ticket Price" name="ticket_types[' + counter + ']price"/></td>';
        cols += '<td class="col-sm-2"><input type="text" class="form-control" placeholder="Amount" name="ticket_types[' + counter + ']max_quantity"/></td>';

        cols += '<td class="col-sm-2"><input type="button" class="ibtnDel btn btn-md btn-danger "  value="Delete"></td>';
        newRow.append(cols);
        $("table.order-list").append(newRow);
        counter++;
        if (counter === 10){
            $("#addrow").attr('disabled', 'disabled');
        }
    });



    $("table.order-list").on("click", ".ibtnDel", function (event) {
        $(this).closest("tr").remove();       
        counter -= 1
        if (counter < 10){
            $("#addrow").removeAttr('disabled');
        }
    });


});