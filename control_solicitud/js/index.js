const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 2000,
    timerProgressBar: true,
    didOpen: (toast) => {
      toast.addEventListener('mouseenter', Swal.stopTimer)
      toast.addEventListener('mouseleave', Swal.resumeTimer)
    }
});
function getDataCli(c){
    $.ajax({
        data: { OPC: 2, d1: c },
        url: urlS('index'),
        type: 'post',
        dataType: 'json',
        success: (r) => {
            document.getElementById('aux_cli').innerHTML = `
            <b>Nombre: </b>${r[1][0][0]}<br>
            <b>Edad: </b>${r[1][0][1]} | <b>Nro socio: </b>${r[1][0][2]}<br>
            `;
        },
        error: (xhr) => {
            Swal.fire({
                icon: 'error',
                title: '¡Ocurrio un error!',
                html: xhr.responseText
            });
        }
    });
}
const AUTO = {
    cli: null,
    aec: null
};
function nCliente(){
    $("#res_modal").html('<iframe src="../control_clientes/index.php?NEW=Y" frameborder="0" width="100%" height="100%"></iframe>');
}
function solicitud(){
    Swal.fire({
        icon: 'info',
        title: '¡Cargando!'
    });
    Swal.showLoading();
    $("#res").html('Cargando...');
    $("#res").load(urlGF("n_solicitud","P=0&F=0&B=0&NV=0"));
    let inter = setInterval(() => {
        if(document.getElementById('auxParam') !== null){
            $('.collapsible').collapsible({accordion: false});
            $('select').formSelect();
            $('.modal').modal();
            M.updateTextFields();
            Swal.close();
            let cli = document.getElementById('npt_cliente');
            AUTO.cli = M.Autocomplete.init(cli, {onAutocomplete:()=>{
                let t = cli.value.split(' | ');
                document.getElementById('npt_aux_cliente').value = t[0];
                getDataCli(t[0]);
            }});
            cli.addEventListener('keyup',(e)=>{
                let v = e.target.value.toUpperCase();
                $.ajax({
                    data: { OPC: 1, d1: v },
                    url: urlS('index'),
                    type: 'post',
                    dataType: 'json',
                    success: (r) => {
                        let t = {};
                        r[1].forEach(item => { t[item[0]] = null; });
                        AUTO.cli.updateData(t);
                        AUTO.cli.open();
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
            });
            let aec = document.getElementById('npt_actividad_economica');
            AUTO.aec = M.Autocomplete.init(aec, {onAutocomplete:()=>{
                let t = aec.value.split(' | ');
                document.getElementById('npt_aux_actividad_economica').value = t[0];
            }});
            aec.addEventListener('keyup',(e)=>{
                let v = e.target.value.toUpperCase();
                $.ajax({
                    data: { OPC: 3, d1: v },
                    url: urlS('index'),
                    type: 'post',
                    dataType: 'json',
                    success: (r) => {
                        let t = {};
                        r[1].forEach(item => { t[item[0]] = null; });
                        AUTO.aec.updateData(t);
                        AUTO.aec.open();
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
            });
            clearInterval(inter);
        }
    }, 350);
}
function vImpresiones(e,a,c){
    e.setAttribute('disabled',true);
    let res = document.getElementById('resImpresiones');
    res.innerHTML = '...';
    Swal.fire({
        icon: 'info',
        title: '¡Cargando!'
    });
    Swal.showLoading();
    $.ajax({
        data: {OPC:4,d1:a,d2:c},
        url: urlS('index'),
        type: 'post',
        dataType: 'json',
        success: (r) => {
            let ht = `
            <table class="blue-grey ligthen-5">
            <tr>${e.parentNode.parentNode.innerHTML}<tr/>
            <table>
            <table class="centered"><thead>
            <tr><th>Usuario</th>
            <th>Fecha</th>
            <th>Ip</th>
            <th>PDF</th></tr>
            </thead><tbody>`;
            r[1].forEach(item => {
                ht += `<tr>
                    <td>${item[0]}</td>
                    <td>${item[1]}</td>
                    <td>${item[2]}</td>
                    <td><a href="./components/historico_pdf.php?F=${item[3]}" target="_blank" class="btn red" ${item[3] < 1 ? 'disabled' : ''}>VER</a></td>
                </tr>`;
            });
            ht += '</tbody></table>';
            res.innerHTML = ht;
            e.removeAttribute('disabled');
            Swal.close();
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
function dSolicitud(e,a,c){
    if(confirm('¿Eliminar solicitud?')){
        e.setAttribute('disabled',true);
        Swal.fire({
            icon: 'info',
            title: '¡Procesando!'
        });
        Swal.showLoading();
        $.ajax({
            data: {OPC:110,d1:a,d2:c},
            url: urlS('index'),
            type: 'post',
            dataType: 'json',
            success: (r) => {
                if (r[0]) {
                    Toast.fire({
                        icon: 'success',
                        title: r[1]
                    });
                    grid(1);
                } else {
                    Toast.fire({
                        icon: 'error',
                        title: r[1]
                    });
                    e.removeAttribute('disabled');
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
function eSolicitud(a,c){
    Swal.fire({
        icon: 'info',
        title: '¡Cargando!'
    });
    Swal.showLoading();
    $("#res").html('Cargando...');
    $("#res").load(urlGF("e_solicitud","A="+a+"&C="+c+""));
    let inter = setInterval(() => {
        if(document.getElementById('auxParam') !== null){
            $('.collapsible').collapsible({accordion: false});
            $('select').formSelect();
            M.updateTextFields();
            Swal.close();
            let aec = document.getElementById('npt_actividad_economica');
            AUTO.aec = M.Autocomplete.init(aec, {onAutocomplete:()=>{
                let t = aec.value.split(' | ');
                document.getElementById('npt_aux_actividad_economica').value = t[0];
            }});
            aec.addEventListener('keyup',(e)=>{
                let v = e.target.value.toUpperCase();
                $.ajax({
                    data: { OPC: 3, d1: v },
                    url: urlS('index'),
                    type: 'post',
                    dataType: 'json',
                    success: (r) => {
                        let t = {};
                        r[1].forEach(item => { t[item[0]] = null; });
                        AUTO.aec.updateData(t);
                        AUTO.aec.open();
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
            });
            clearInterval(inter);
        }
    }, 350);
}
function grd(){window.location.href = './';}
function grid(p){
    Swal.fire({
        icon: 'info',
        title: '¡Cargando!'
    });
    Swal.showLoading();
    let b = document.getElementById('npt_busqueda').value.toUpperCase();
    let fi = document.getElementById('npt_fecha_inicio').value;
    let ff = document.getElementById('npt_fecha_final').value;
    let es = document.getElementById('npt_estado').value;
    $("#res_grid").load(urlGF("grid","P="+p+"&B="+b+"&FI="+fi+"&FF="+ff+"&ES="+es));
    let inter = setInterval(() => {
        if(document.getElementById('auxParam') !== null){
            //$('.collapsible').collapsible({accordion: false});
            $('select').formSelect();
            M.updateTextFields();
            $('.modal').modal();
            Swal.close();
            clearInterval(inter);
        }
    }, 350);
}
function pValSol(e) {
    e.select();
}
function uValSol(e,d3,d4,d5,d6) {
    e.setAttribute('disabled',true);
    let age = document.getElementById('npt_agencia').value;
    let cod = document.getElementById('npt_codigo').value;
    if(e.value != ''){
        $.ajax({
            data: {OPC:101,d1:age,d2:cod,d3:d3,d4:d4,d5:d5,d6:d6,d7:e.value},
            url: urlS('index'),
            type: 'post',
            dataType: 'json',
            success: (r) => {
                if (r[0]) {
                    Toast.fire({
                        icon: 'success',
                        title: r[1]
                    });
                    resumen();
                } else {
                    Toast.fire({
                        icon: 'error',
                        title: r[1]
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
function uSigSol(e,d3,d4,d5,d6) {
    e.setAttribute('disabled',true);
    let age = document.getElementById('npt_agencia').value;
    let cod = document.getElementById('npt_codigo').value;
    if(e.value != ''){
        $.ajax({
            data: {OPC:103,d1:age,d2:cod,d3:d3,d4:d4,d5:d5,d6:d6,d7:e.value},
            url: urlS('index'),
            type: 'post',
            dataType: 'json',
            success: (r) => {
                if (r[0]) {
                    Toast.fire({
                        icon: 'success',
                        title: r[1]
                    });
                    resumen();
                } else {
                    Toast.fire({
                        icon: 'error',
                        title: r[1]
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
function iItmSol(e,d3,d4,d5,auxt1) {
    Swal.fire({
        title: auxt1,
        html: `<div class="row">
        <div class="col s12"><input type="text" id="npt_aux_item" placeholder="Item"></div>
        <div class="col s8"><input type="number" id="npt_aux_valor" placeholder="Valor" step="0.01"></div>
        <div class="col s4">
            <select id="npt_aux_signo" class="browser-default">
                <option value="+" selected>+</option>
                <option value="-">-</option>
            </select>
        </div>
        </div>`,
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Agregar!',
        allowOutsideClick: false
    }).then((result) => {
        if (result.isConfirmed) {
            let age = document.getElementById('npt_agencia').value;
            let cod = document.getElementById('npt_codigo').value;
            let itm = document.getElementById("npt_aux_item").value.toUpperCase();
            let val = document.getElementById("npt_aux_valor").value;
            let sig = document.getElementById("npt_aux_signo").value;
            if(itm.value != '' && val.value != '' && sig.value != ''){
                $.ajax({
                    data: {OPC:104,d1:age,d2:cod,d3:d3,d4:d4,d5:d5,d100:itm,d101:val,d102:sig},
                    url: urlS('index'),
                    type: 'post',
                    dataType: 'json',
                    success: (r) => {
                        if (r[0]) {
                            eSolicitud(age,cod);
                        } else {
                            Toast.fire({
                                icon: 'error',
                                title: r[1]
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
    });
    document.getElementById("npt_aux_item").focus();
}
function dItmSol(e,d3,d4,d5,d6,auxt1) {
    e.setAttribute('disabled',true);
    let age = document.getElementById('npt_agencia').value;
    let cod = document.getElementById('npt_codigo').value;
    if(confirm('¿Eliminar registro?\n'+auxt1+'.')){
        $.ajax({
            data: {OPC:105,d1:age,d2:cod,d3:d3,d4:d4,d5:d5,d6:d6},
            url: urlS('index'),
            type: 'post',
            dataType: 'json',
            success: (r) => {
                if (r[0]) {
                    Toast.fire({
                        icon: 'success',
                        title: r[1]
                    });
                    eSolicitud(age,cod);
                } else {
                    Toast.fire({
                        icon: 'error',
                        title: r[1]
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

function uValSol5c(e,d3,d4) {
    e.setAttribute('disabled',true);
    let age = document.getElementById('npt_agencia').value;
    let cod = document.getElementById('npt_codigo').value;
    if(e.value != ''){
        $.ajax({
            data: {OPC:102,d1:age,d2:cod,d3:d3,d4:d4,d5:e.value},
            url: urlS('index'),
            type: 'post',
            dataType: 'json',
            success: (r) => {
                if (r[0]) {
                    Toast.fire({
                        icon: 'success',
                        title: r[1]
                    });
                    resumen();
                } else {
                    Toast.fire({
                        icon: 'error',
                        title: r[1]
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
function iSolicitud() {
    let cli = [document.getElementById('npt_cliente'),document.getElementById('npt_aux_cliente')];
    let aec = [document.getElementById('npt_actividad_economica'),document.getElementById('npt_aux_actividad_economica')];
    let mat = document.getElementById('npt_matriz');
    let fec = document.getElementById('npt_fecha');
    let mon = document.getElementById('npt_monto');
    let int = document.getElementById('npt_interes');
    let pla = document.getElementById('npt_plazo');
    let cuo = document.getElementById('npt_cuota');
    if(cli[0].value == '' || cli[1].value == ''){
        cli[0].focus();
        M.toast({html: '¡Cliente, campo obligatorio!', classes: 'rounded red'})
        return;
    }
    if(aec[0].value == '' || aec[1].value == ''){
        aec[0].focus();
        M.toast({html: 'Actividad economica, campo obligatorio!', classes: 'rounded red'})
        return;
    }
    if(mat.value == ''){
        M.toast({html: 'Tipo matriz, campo obligatorio!', classes: 'rounded red'})
        return;
    }
    if(fec.value == ''){
        fec.focus();
        M.toast({html: 'Fecha, campo obligatorio!', classes: 'rounded red'})
        return;
    }
    if(mon.value == ''){
        mon.focus();
        M.toast({html: 'Monto, campo obligatorio!', classes: 'rounded red'})
        return;
    }
    if(int.value == ''){
        int.focus();
        M.toast({html: 'Interes, campo obligatorio!', classes: 'rounded red'})
        return;
    }
    if(pla.value == ''){
        pla.focus();
        M.toast({html: 'Plazo, campo obligatorio!', classes: 'rounded red'})
        return;
    }
    if(cuo.value == ''){
        cuo.focus();
        M.toast({html: 'Cuota, campo obligatorio!', classes: 'rounded red'})
        return;
    }
    let data = {
        OPC: 100,
        d1: cli[1].value,
        d2: aec[1].value,
        d3: mat.value,
        d4: fec.value,
        d5: mon.value,
        d6: int.value,
        d7: pla.value,
        d8: cuo.value,
        d9: $("input[name='npt_listas']:checked").val(),
        d10: $("input[name='npt_vinculado']:checked").val(),
        d11: $("input[name='npt_inspeccion']:checked").val(),
    };
    $.ajax({
        data: data,
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
                eSolicitud(r[2],r[3]);
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
function uSolicitud(e,a,c) {
    let aec = [document.getElementById('npt_actividad_economica'),document.getElementById('npt_aux_actividad_economica')];
    let mat = document.getElementById('npt_matriz');
    let fec = document.getElementById('npt_fecha');
    let mon = document.getElementById('npt_monto');
    let int = document.getElementById('npt_interes');
    let pla = document.getElementById('npt_plazo');
    let cuo = document.getElementById('npt_cuota');
    if(aec[0].value == '' || aec[1].value == ''){
        aec[0].focus();
        M.toast({html: 'Actividad economica, campo obligatorio!', classes: 'rounded red'})
        return;
    }
    if(mat.value == ''){
        M.toast({html: 'Tipo matriz, campo obligatorio!', classes: 'rounded red'})
        return;
    }
    if(fec.value == ''){
        fec.focus();
        M.toast({html: 'Fecha, campo obligatorio!', classes: 'rounded red'})
        return;
    }
    if(mon.value == ''){
        mon.focus();
        M.toast({html: 'Monto, campo obligatorio!', classes: 'rounded red'})
        return;
    }
    if(int.value == ''){
        int.focus();
        M.toast({html: 'Interes, campo obligatorio!', classes: 'rounded red'})
        return;
    }
    if(pla.value == ''){
        pla.focus();
        M.toast({html: 'Plazo, campo obligatorio!', classes: 'rounded red'})
        return;
    }
    if(cuo.value == ''){
        cuo.focus();
        M.toast({html: 'Cuota, campo obligatorio!', classes: 'rounded red'})
        return;
    }
    e.setAttribute('disabled',true);
    let data = {
        OPC: 109,
        d0: a,
        d1: c,
        d2: aec[1].value,
        d3: mat.value,
        d4: fec.value,
        d5: mon.value,
        d6: int.value,
        d7: pla.value,
        d8: cuo.value,
        d9: $("input[name='npt_listas']:checked").val(),
        d10: $("input[name='npt_vinculado']:checked").val(),
        d11: $("input[name='npt_inspeccion']:checked").val(),
    };
    $.ajax({
        data: data,
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
                eSolicitud(a, c);
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
function resumen(){
    document.getElementById('resumen').innerHTML = 'Cargando...';
    let age = document.getElementById('npt_agencia').value;
    let cod = document.getElementById('npt_codigo').value;
    $("#resumen").load(urlGF("e_solicitud_resumen","A="+age+"&C="+cod));
    let inter = setInterval(() => {
        if(document.getElementById('auxParamResumen') !== null){
            $('.collapsible').collapsible();
            M.updateTextFields();
            Swal.close();
            clearInterval(inter);
        }
    }, 350);
}

function shwHdResumen(e){
    let ctrl = e.parentNode.children[0].className;
    if(ctrl == 'resumen-content'){
        e.parentNode.children[0].className = 'resumen-content hide';
    }else{
        e.parentNode.children[0].className = 'resumen-content';
        resumen();
    }
}

function chaRecCre(e) {
    let des = document.getElementById('npt_des_reccre').value;
    while(des=='') {
        des = prompt('Indique la razón (Campo obligatorio)','');
    }
    if(des != '' && des != null){
        let age = document.getElementById('npt_agencia').value;
        let cod = document.getElementById('npt_codigo').value;
        $.ajax({
            data: {OPC:107,d1:age,d2:cod,d3:e.value,d4:des},
            url: urlS('index'),
            type: 'post',
            dataType: 'json',
            success: (r) => {
                if (r[0]) {
                    Toast.fire({
                        icon: 'success',
                        title: r[1]
                    });
                    resumen();
                } else {
                    Toast.fire({
                        icon: 'error',
                        title: r[1]
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
    }else{
        e.checked = false;
    }
}
function chaMarImp(e) {
    if(e.value != '' && !isNaN(e.value)){
        let age = document.getElementById('npt_agencia').value;
        let cod = document.getElementById('npt_codigo').value;
        $.ajax({
            data: {OPC:106,d1:age,d2:cod,d3:e.value},
            url: urlS('index'),
            type: 'post',
            dataType: 'json',
            success: (r) => {
                if (r[0]) {
                    Toast.fire({
                        icon: 'success',
                        title: r[1]
                    });
                    resumen();
                } else {
                    Toast.fire({
                        icon: 'error',
                        title: r[1]
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
    }else{
        alert('¡Ingrese un valor valido!');
    }
}
function chaDesRecCre(e) {
    let des = e.value;
    let reccre = ['',document.getElementsByName('npt_reccre')];
    reccre[1].forEach(item => {
        if(item.checked)reccre[0] = item.value;
    });
    if(reccre[0] != ''){
        if(des != ''){
            let age = document.getElementById('npt_agencia').value;
            let cod = document.getElementById('npt_codigo').value;
            $.ajax({
                data: {OPC:108,d1:age,d2:cod,d3:des},
                url: urlS('index'),
                type: 'post',
                dataType: 'json',
                success: (r) => {
                    if (r[0]) {
                        Toast.fire({
                            icon: 'success',
                            title: r[1]
                        });
                        resumen();
                    } else {
                        Toast.fire({
                            icon: 'error',
                            title: r[1]
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
        }else{
            alert('¡Indique la razón!');
        }
    }else{
        alert('¡Seleccione si recomienda el crédito!');
    }
}
function repSolicitud(){
    let age = document.getElementById('npt_agencia').value;
    let cod = document.getElementById('npt_codigo').value;
    window.open('./components/report_solicitud_pdf.php?A='+age+'&C='+cod,'_blank');
}
document.addEventListener('DOMContentLoaded', function () {
    M.AutoInit();
    grid(1);
});