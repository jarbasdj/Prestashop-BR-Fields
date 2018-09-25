$(function () {
    let $postCode = $('input[name="postcode"]');
    let $address1 = $('input[name="address1"]');
    let $address2 = $('input[name="address2"]'); // Complemento
    let $addressNumber = $('input[name="address_number"]');
    let $addressNeighborhood = $('input[name="address_neighborhood"]');
    let $city = $('input[name="city"]');
    let $state = $('select[name="id_state"]');

    // Máscara
    $postCode.mask('00000-000');
    $('input[name="phone"]')
        .mask('(00) 00000-0000')
        .focusout(function () {
            let target, phone, element;

            target = event.srcElement;
          
            phone = target.value.replace(/\D/g, '');
            element = $(target);
            element.unmask();

            if (phone.length > 10) {               
                element.mask("(00) 00000-0000");
            } else {
                element.mask("(00) 0000-0000");
            }
        });

    // Busca o endereço pelo CEP
    $postCode.on('blur', function () {
        if ($(this).val() === '') {
            return false;
        }

        // Limpa o complemento
        $address2.val('');

        // Mostra o preloader
        $('span.postcode').show();

        $.ajax({
            url: 'http://cep.republicavirtual.com.br/web_cep.php',
            type: 'GET',
            data: {
                cep: $postCode.val(),
                formato: 'jsonp'
            },
            dataType: 'jsonp',
            crossOrigin: true,
            timeout: 5000
        }).done(function (result) {
            if (result.resultado == 1) {
                $address1.val(result.tipo_logradouro + ' ' + result.logradouro);
                $city.val(result.cidade);

                // Seleciona o ID do estado na lista com base no iso_code retornado pela api
                let id_state = $('select[name="id_state"] option').filter(function () {
                    return $(this).html() == result.uf
                }).val();

                $state.val(id_state);

                $addressNeighborhood.val(result.bairro);

                $addressNumber.focus();
            } else {
                $address1.val('');
                $addressNeighborhood.val('');

                alert('Não conseguimos encontrar seu endereço. Preencha manualmente os dados.');
            }
        }).always(function () {
            // Esconde o preloader
            $('span.postcode').hide();
        });
    });
})