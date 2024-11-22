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
function cliente(){
    Swal.fire({
        icon: 'info',
        title: '¡Cargando!'
    });
    Swal.showLoading();
    $("#res").html('Cargando...');
    $("#res").load(urlGF("n_cliente","P=0&F=0&B=0&NV=0"));
    let inter = setInterval(() => {
        if(document.getElementById('auxParam') !== null){
            $('.collapsible').collapsible({accordion: false});
            $('select').formSelect();
            M.updateTextFields();
            Swal.close();
            clearInterval(inter);
        }
    }, 350);
}
function eCliente(c){
    Swal.fire({
        icon: 'info',
        title: '¡Cargando!'
    });
    Swal.showLoading();
    $("#res").html('Cargando...');
    $("#res").load(urlGF("e_cliente","COD="+c));
    let inter = setInterval(() => {
        if(document.getElementById('auxParam') !== null){
            $('.collapsible').collapsible({accordion: false});
            $('select').formSelect();
            M.updateTextFields();
            Swal.close();
            clearInterval(inter);
        }
    }, 350);
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
    $("#res_grid").load(urlGF("grid","P="+p+"&B="+b));
    let inter = setInterval(() => {
        if(document.getElementById('auxParam') !== null){
            //$('.collapsible').collapsible({accordion: false});
            $('select').formSelect();
            M.updateTextFields();
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

function chaProvincia(e) {
    if(e.value != ''){
        $.ajax({
            data: {OPC:101,d1:e.value},
            url: urlS('index'),
            type: 'post',
            dataType: 'json',
            success: (r) => {
                let can = document.getElementById('npt_canton');
                can.innerHTML = '<option value="" disabled selected>Seleccionar</option>';
                r[1].forEach(item => {
                    let opc = document.createElement('option');
                    opc.setAttribute('value',item[0]);
                    opc.innerHTML = item[1];
                    can.appendChild(opc);
                });
                $('select').formSelect();
                if (!r[0]) {
                    Toast.fire({
                        icon: 'error',
                        title: '¡NO SE ENCONTRARON CANTONES!'
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
function iCliente(e) {
    e.preventDefault();
    let fmr = document.getElementById('fmr_cli');
    let data = {};
    for (let i=0;i<22;i++) {
        if(fmr.elements[i].id != ''){
            data[fmr.elements[i].id] = fmr.elements[i].value;
        }
    }
    for (let i=0;i<19;i++) {
        switch (fmr.elements[i].tagName) {
            case 'INPUT':
                if(fmr.elements[i].value == ''){
                    fmr.elements[i].focus();
                    fmr.elements[i].classList.add("invalid");
                    return;
                }
                break;
            case 'SELECT':
                if(fmr.elements[i].value == ''){
                    fmr.elements[i].previousSibling.previousSibling.previousSibling.focus();
                    fmr.elements[i].previousSibling.previousSibling.previousSibling.classList.add("invalid");
                    return;
                }
                break;
        }
    }
    data['OPC'] = 100;
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
                cliente();
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
function uCliente(e) {
    e.preventDefault();
    let fmr = document.getElementById('fmr_cli');
    let data = {};
    for (let i=0;i<23;i++) {
        if(fmr.elements[i].id != ''){
            data[fmr.elements[i].id] = fmr.elements[i].value;
        }
    }
    for (let i=0;i<20;i++) {
        switch (fmr.elements[i].tagName) {
            case 'INPUT':
                if(fmr.elements[i].value == ''){
                    fmr.elements[i].focus();
                    fmr.elements[i].classList.add("invalid");
                    return;
                }
                break;
            case 'SELECT':
                if(fmr.elements[i].value == ''){
                    fmr.elements[i].previousSibling.previousSibling.previousSibling.focus();
                    fmr.elements[i].previousSibling.previousSibling.previousSibling.classList.add("invalid");
                    return;
                }
                break;
        }
    }
    data['OPC'] = 102;
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
                Toast.fire({
                    icon: 'success',
                    title: r[1]
                });
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
function uplFlList(e){
    e.preventDefault();
    let fl = document.getElementById("archivo");
    let fs = fl.files;
    let f = new FormData();
    let extval = ['xlsx'];
    for(var i=0;i<fs.length;i++){
        var tmp_name = fs[i].name.split(".");
        var tp_len = tmp_name.length;
        var ext = tmp_name[tp_len-1];
        let ctrl1 = true;
        for(let i=0;i<extval.length; i++) {
            if(ext !== extval[i]){
                ctrl1 = false;
            }else{
                ctrl1 = true;
                break;
            };
        }
        if(!ctrl1){
            alert("Seleccione los archivos con una extencion valida (xlsx)");
            return false;
        }
        f.append('f'+i,fs[i]);
    }
    if(fs.length === 0){
        M.toast({html: '¡Seleccione por lo menos un archivo!',classes: 'red'});
    }else{
        f.append('OPC',103);
        $.ajax({
            data:  f,
            url:   urlS('index'),
            contentType: false,
            processData: false,
            cache: false,
            type:  'post',
            dataType: 'json',
            beforeSend: function(){
                M.toast({html: '¡Procesando...!'});
                document.getElementById('btnUpdFile').disabled = true;
                document.getElementById('resData').innerHTML = '<div class="progress"><div class="indeterminate"></div></div>';
            },
            success: function(r) {
                if(r[0]){
                    M.toast({html: r[1],classes: 'green'});
                    document.getElementById('resData').innerHTML = 
                        '<ul class="collection"><li class="collection-item green">'+r[1]+'</li></ul>';
                }else{
                    M.toast({html: r[1],classes: 'red'});
                    document.getElementById('resData').innerHTML = 
                        '<ul class="collection"><li class="collection-item red">'+r[1]+'</li></ul>';
                }
                document.getElementById('archivo').value = '';
                document.getElementById('btnUpdFile').disabled = false;
                grid(1);
            },
            error: function(xhr){
                document.getElementById('btnUpdFile').disabled = false;
                document.getElementById('resData').innerHTML = '';
                M.toast({html: '¡Ocurrio un error!',classes: 'red'});
                console.error(xhr.responseText);
            }
        });
    }
}
document.addEventListener('DOMContentLoaded', function () {
    M.AutoInit();
    grid(1);
});