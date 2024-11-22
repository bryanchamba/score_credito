function preEliminar(rg, des) {
    Swal.fire({
        title: '¿Eliminar?',
        html: `${des}`,
        icon: 'info',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Sí, eliminar!'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                data: { OPC: 'DUSU', d1: rg },
                url: urlS('index'),
                type: 'post',
                dataType: 'json',
                beforeSend: function () {
                    Swal.fire({
                        icon: 'info',
                        title: '¡Procesando...!',
                        allowOutsideClick: false
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
    });
}
function fmrAdd() {
    Swal.fire({
        title: 'Nuevo',
        html: `<form onsubmit="add(event);"><div class="input-field"><input type="text" id="npt_usuari" required><label for="npt_usuari">Usuario  <span class="red-text">*</span></label></div>
            <div class="input-field"><input type="password" id="npt_contra" required autocomplete="off"><label for="npt_contra">Contraseña<span class="red-text">*</span></label></div>
            <div class="input-field"><input type="password" id="npt_repcon" required autocomplete="off"><label for="npt_repcon">Repita contraseña <span class="red-text">*</span></label></div>
            <div class="input-field"><input type="number" id="npt_cedula" required><label for="npt_cedula">Cedula <span class="red-text">*</span></label></div>
            <div class="input-field"><input type="text" id="npt_apelli" required><label for="npt_apellidos">Apellidos <span class="red-text">*</span></label></div>
            <div class="input-field"><input type="text" id="npt_nombre" required><label for="npt_nombres">Nombres <span class="red-text">*</span></label></div>
            <div class="input-field"><input type="email" id="npt_email" required><label for="npt_email">Email <span class="red-text">*</span></label></div>
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
    let ce = document.getElementById("npt_cedula");
    let ap = document.getElementById("npt_apelli");
    let nm = document.getElementById("npt_nombre");
    let em = document.getElementById("npt_email");
    if(us.value == '' || ps.value == '' || rp.value == '' || ce.value == '' || ap.value == '' || nm.value == '' || em.value == ''){
        alert('¡Llene todos los campos obligatorios (*)!');
    }else{
        if(ps.value != rp.value){
            alert('¡Contraseñas no coinciden!');
            ps.value = '';
            rp.value = '';
            ps.focus();
        }else{
            $.ajax({
                data: { OPC: 'IUSU', 
                    d1: us.value, 
                    d2: ps.value, 
                    d3: ce.value, 
                    d4: ap.value.toUpperCase().substring(0, 75), 
                    d5: nm.value.toUpperCase().substring(0, 75), 
                    d6: em.value 
                },
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
        html: `<input type="text" id="npt_macrop" placeholder="Nombre" value="${vl}" disabled>
            <p>
                <label>
                    <input class="with-gap" name="npt_estado" value="A" type="radio" ${ac == 'A' ? 'checked' : ''} />
                    <span>Activo</span>
                </label>
                <label>
                    <input class="with-gap" name="npt_estado" value="I" type="radio" ${ac != 'A' ? 'checked' : ''} />
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
function edit(cd, nm, ac) {
    if(nm[0] == ''){
        alert('¡Nombre no puede quedar vacío!');
    }else{
        $.ajax({
            data: { OPC: 'UUSU', d1: cd, d2: ac[0] },
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