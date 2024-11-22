function fmrAdd() {
    Swal.fire({
        title: 'Nuevo',
        html: `<form onsubmit="add(event);"><div class="input-field"><input type="text" id="npt_usuari" required><label for="npt_usuari">Usuario  <span class="red-text">*</span></label></div>
            <div class="input-field"><input type="password" id="npt_contra" required autocomplete="off"><label for="npt_contra">Contraseña<span class="red-text">*</span></label></div>
            <div class="input-field"><input type="password" id="npt_repcon" required autocomplete="off"><label for="npt_repcon">Repita contraseña <span class="red-text">*</span></label></div>
            <div class="input-field"><input type="text" id="npt_nombre" required><label for="npt_nombre">Nombre <span class="red-text">*</span></label></div>
            <button class="btn blue">Agregar!</button>
            </form>`,
        showCancelButton: true,
        cancelButtonColor: '#d33',
        showConfirmButton: false,
        allowOutsideClick: false
    });
    let cmp = document.getElementById('npt_usuari');
    cmp.focus();

}
function add(e){
    e.preventDefault();
    let us = document.getElementById("npt_usuari");
    let ps = document.getElementById("npt_contra");
    let rp = document.getElementById("npt_repcon");
    let nm = document.getElementById("npt_nombre");
    if(us.value == '' || ps.value == '' || rp.value == '' || nm.value == ''){
        alert('¡Llene todos los campos obligatorios (*)!');
    }else{
        if(ps.value != rp.value){
            alert('¡Contraseñas no coinciden!');
            ps.value = '';
            rp.value = '';
            ps.focus();
        }else{
            $.ajax({
                data: { OPC: 'IUSU', d1: us.value, d2: ps.value, d3: nm.value.toUpperCase().substring(0, 64) },
                url: urlS('index'),
                type: 'post',
                dataType: 'json',
                beforeSend: function () {
                    Swal.close();
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
}
function fmrEdit(cd, vl, ac) {
    Swal.fire({
        title: 'Editar',
        html: `<input type="text" id="npt_macrop" placeholder="Nombre" value="${vl}">
            <p>
                <label>
                    <input class="with-gap" name="npt_estado" value="Y" type="radio" ${ac == 'Y' ? 'checked' : ''} />
                    <span>Activo</span>
                </label>
                <label>
                    <input class="with-gap" name="npt_estado" value="N" type="radio" ${ac != 'Y' ? 'checked' : ''} />
                    <span>Inactivo</span>
                </label>
            </p>`,
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Actualizar!',
        allowOutsideClick: false
    }).then((result) => {
        if (result.isConfirmed) {
            let val = document.getElementById("npt_macrop").value;
            let act = document.querySelector("input[name=npt_estado]:checked").value;

            edit(cd, [val, vl], [act, ac]);
        }
    });
    let cmp = document.getElementById('npt_macrop');
    cmp.select();
}
function edit(e,f) {
    e.preventDefault();
    if(f.elements.npt_newpas.value != f.elements.npt_reppas.value){
        alert('¡Nueva contraseña no coincide!');
        f.elements.npt_newpas.value = '';
        f.elements.npt_reppas.value = '';
        f.elements.npt_newpas.focus();
    }else{
        $.ajax({
            data: { OPC: 'UUSU', d1: f.elements.npt_newpas.value },
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
                    Swal.fire({
                        icon: 'success',
                        html: r[1]
                    });
                    f.innerHTML = r[1];
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
    let fmr = document.getElementById('fmr');
    fmr.addEventListener('submit',(e)=>edit(e,fmr));
});