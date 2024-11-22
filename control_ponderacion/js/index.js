function fmrEdit(cd, vl) {
    Swal.fire({
        title: 'Editar',
        html: '<input type="text" id="npt_macrop" placeholder="EMPRESA" value="'+vl+'">',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Actualizar!',
        allowOutsideClick: false
    }).then((result) => {
        if (result.isConfirmed) {
            let val = document.getElementById("npt_macrop");
            edit(cd, val.value, vl);
        }
    });
    let cmp = document.getElementById('npt_macrop');
    cmp.select();

}
function edit(e, est, mm) {
    if(e.value == ''){
        alert('¡Valor no puede quedar vacío!');
    }else{
        e.setAttribute('disabled',true);
        $.ajax({
            data: { OPC: 'UPON', d1: est, d2: e.value, d3: mm },
            url: urlS('index'),
            type: 'post',
            dataType: 'json',
            beforeSend: function () {
                Swal.fire({
                    icon: 'info',
                    title: '¡Procesando...!'
                });
                Swal.showLoading();
            },
            success: (r) => {
                Swal.close();
                if (r[0]) {
                    M.toast({html: r[1], classes: 'rounded green'});
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: '¡Ocurrio un error!',
                        html: r[1]
                    });
                }
                e.removeAttribute('disabled');
            },
            error: (xhr) => {
                Swal.close();
                Swal.fire({
                    icon: 'error',
                    title: '¡Ocurrio un error!',
                    html: xhr.responseText
                });
            }
        });
    }
}
document.addEventListener('DOMContentLoaded', function () {

});