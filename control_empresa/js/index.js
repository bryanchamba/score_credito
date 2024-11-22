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
function edit(cd, vl, old) {
    if(vl == ''){
        alert('¡Nombre no puede quedar vacío!');
    }else{
        $.ajax({
            data: { OPC: 'UEMP', d1: cd, d2: vl.substring(0, 100), d3: old },
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
                    location.href = r[1];
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: '¡Ocurrio un error!',
                        html: r[1]
                    });
                }
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