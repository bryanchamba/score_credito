function ini(){
    $.ajax({
        data: { OPC: 'INI' },
        url: urlS('index'),
        type: 'post',
        dataType: 'json',
        beforeSend: function () {
            
        },
        success: function (r) {
            
        },
        error: function (xhr) {
            
        }
    });
}
function item(dr){
    $('#main').html('Cargando...');
    $('#main').html('<iframe src="../'+dr+'" frameborder="0" width="100%" height="100%"></iframe>');
}
document.addEventListener('DOMContentLoaded', function () {
    
});
