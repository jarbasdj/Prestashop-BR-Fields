{extends file='customer/page.tpl'}

{block name='page_title'}
    {if $editing}
        {l s='Update your address' d='Shop.Theme.Customeraccount'}
    {else}
        {l s='New address' d='Shop.Theme.Customeraccount'}
    {/if}
{/block}

{block name='page_content'}
    {block name="address_form"}
        <div class="js-address-form">
            {include file='_partials/form-errors.tpl' errors=$errors['']}

            {block name="address_form_url"}
                <form
                    method="POST"
                    action="{url entity='address' params=['id_address' => $id_address]}"
                    data-id-address="{$id_address}"
                    data-refresh-url="{url entity='address' params=['ajax' => 1, 'action' => 'addressForm']}"
                >
            {/block}

            {block name="address_form_fields"}
                <section class="form-fields">
                    {block name='form_fields'}
                        {foreach from=$formFields item="field"}
                            {if $field.type == 'hidden'}
                                {block name='form_field_item_hidden'}
                                    <input type="hidden" name="{$field.name}" value="{$field.value}">
                                {/block}
                            {else}
                                <div class="form-group row {if !empty($field.errors)}has-error{/if}">
                                    <label class="col-md-3 form-control-label{if $field.required} required{/if}">
                                        {if $field.type !== 'checkbox'}
                                            {if $field.name === 'address_number'}
                                                {l s='Número' mod='brazilianfields'}
                                            {elseif  $field.name === 'address_neighborhood'}
                                                {l s='Bairro' mod='brazilianfields'}
                                            {else}
                                                {$field.label}
                                            {/if}
                                        {/if}
                                    </label>

                                    <div class="col-md-6{if ($field.type === 'radio-buttons')} form-control-valign{/if}">
                                        {if $field.type === 'select'}
                                            {block name='form_field_item_select'}
                                                <select class="form-control form-control-select" name="{$field.name}" {if $field.required}required{/if}>
                                                    <option value disabled selected>{l s='-- please choose --' d='Shop.Forms.Labels'}</option>
                                                    
                                                    {foreach from=$field.availableValues item="label" key="value"}
                                                        <option value="{$value}" {if $value eq $field.value} selected {/if}>{$label}</option>
                                                    {/foreach}
                                                </select>
                                            {/block}
                                        {elseif $field.type === 'countrySelect'}
                                            {block name='form_field_item_country'}
                                                <select
                                                    class="form-control form-control-select js-country"
                                                    name="{$field.name}"
                                                    {if $field.required}required{/if}
                                                >
                                                    <option value disabled selected>{l s='-- please choose --' d='Shop.Forms.Labels'}</option>

                                                    {foreach from=$field.availableValues item="label" key="value"}
                                                        <option value="{$value}" {if $value eq $field.value} selected {/if}>{$label}</option>
                                                    {/foreach}
                                                </select>
                                            {/block}
                                        {elseif $field.type === 'radio-buttons'}
                                            {block name='form_field_item_radio'}
                                                {foreach from=$field.availableValues item="label" key="value"}
                                                    <label class="radio-inline">
                                                        <span class="custom-radio">
                                                            <input
                                                                name="{$field.name}"
                                                                type="radio"
                                                                value="{$value}"
                                                                {if $field.required}required{/if}
                                                                {if $value eq $field.value} checked {/if}
                                                            >
                                                            <span></span>
                                                        </span>
                                                        {$label}
                                                    </label>
                                                {/foreach}
                                            {/block}
                                        {elseif $field.type === 'checkbox'}
                                            {block name='form_field_item_checkbox'}
                                                <span class="custom-checkbox">
                                                    <input name="{$field.name}" type="checkbox" value="1" {if $field.value}checked="checked"{/if} {if $field.required}required{/if}>
                                                    <span><i class="material-icons rtl-no-flip checkbox-checked">&#xE5CA;</i></span>
                                                    <label>{$field.label nofilter}</label>
                                                </span>
                                            {/block}
                                        {elseif $field.type === 'date'}
                                            {block name='form_field_item_date'}
                                                <input name="{$field.name}" class="form-control" type="date" value="{$field.value}" placeholder="{if isset($field.availableValues.placeholder)}{$field.availableValues.placeholder}{/if}">
                                                
                                                {if isset($field.availableValues.comment)}
                                                    <span class="form-control-comment">
                                                        {$field.availableValues.comment}
                                                    </span>
                                                {/if}
                                            {/block}
                                        {elseif $field.type === 'birthday'}
                                            {block name='form_field_item_birthday'}
                                                <div class="js-parent-focus">
                                                    {html_select_date
                                                        field_order=DMY
                                                        time={$field.value}
                                                        field_array={$field.name}
                                                        prefix=false
                                                        reverse_years=true
                                                        field_separator='<br>'
                                                        day_extra='class="form-control form-control-select"'
                                                        month_extra='class="form-control form-control-select"'
                                                        year_extra='class="form-control form-control-select"'
                                                        day_empty={l s='-- day --' d='Shop.Forms.Labels'}
                                                        month_empty={l s='-- month --' d='Shop.Forms.Labels'}
                                                        year_empty={l s='-- year --' d='Shop.Forms.Labels'}
                                                        start_year={'Y'|date}-100 end_year={'Y'|date}
                                                    }
                                                </div>
                                            {/block}
                                        {elseif $field.type === 'password'}
                                            {block name='form_field_item_password'}
                                                <div class="input-group js-parent-focus">
                                                    <input
                                                        class="form-control js-child-focus js-visible-password"
                                                        name="{$field.name}"
                                                        type="password"
                                                        value=""
                                                        pattern=".{literal}{{/literal}5,{literal}}{/literal}"
                                                        {if $field.required}required{/if}
                                                    >
                                                    <span class="input-group-btn">
                                                        <button
                                                            class="btn"
                                                            type="button"
                                                            data-action="show-password"
                                                            data-text-show="{l s='Show' d='Shop.Theme.Actions'}"
                                                            data-text-hide="{l s='Hide' d='Shop.Theme.Actions'}"
                                                        >
                                                            {l s='Show' d='Shop.Theme.Actions'}
                                                        </button>
                                                    </span>
                                                </div>
                                            {/block}
                                        {else}
                                            <input
                                                class="form-control"
                                                name="{$field.name}"
                                                type="{$field.type}"
                                                value="{$field.value}"
                                                {if isset($field.availableValues.placeholder)}placeholder="{$field.availableValues.placeholder}"{/if}
                                                {if $field.maxLength}maxlength="{$field.maxLength}"{/if}
                                                {if $field.required}required{/if}
                                            >
                                            {if isset($field.availableValues.comment)}
                                                <span class="form-control-comment">
                                                    {$field.availableValues.comment}
                                                </span>
                                            {/if}

                                            {* Cria o preloader para mostrar durante o carregamento do CEP *}
                                            {if $field.name === 'postcode'}
                                                <span class="postcode" style="display: none">
                                                    <p class="mt-1 mb-1"><img src="{$uri}views/img/spinner.gif"> <small>{l s="Carregando endereço. Aguarde..." mod="brazilianfields"}</small></p>
                                                </span>
                                            {/if}
                                        {/if}

                                        {block name='form_field_errors'}
                                            {include file='_partials/form-errors.tpl' errors=$field.errors}
                                        {/block}
                                    </div>

                                    <div class="col-md-3 form-control-comment">
                                        {block name='form_field_comment'}
                                            {if (!$field.required && !in_array($field.type, ['radio-buttons', 'checkbox']))}
                                                {l s='Optional' d='Shop.Forms.Labels'}
                                            {/if}
                                        {/block}
                                    </div>
                                </div>
                            {/if}
                        {/foreach}
                    {/block}
                </section>
            {/block}

            {block name="address_form_footer"}
                <footer class="form-footer clearfix">
                    <input type="hidden" name="submitAddress" value="1">
                    {block name='form_buttons'}
                        <button class="btn btn-primary float-xs-right" type="submit" class="form-control-submit">
                            {l s='Save' d='Shop.Theme.Actions'}
                        </button>
                    {/block}
                </footer>
            {/block}
            </form>
        </div>
    {/block}
{/block}