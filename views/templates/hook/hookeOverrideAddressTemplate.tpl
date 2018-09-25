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
                            <div class="form-group row {if !empty($field.errors)}has-error{/if}">
                                <label class="col-md-3 form-control-label{if $field.required} required{/if}">
                                    {if $field.type !== 'checkbox'}
                                        {if $field.name === 'address_number'}
                                            {l s='Número' mod="brazilianfields"}
                                        {elseif $field.name === 'address_neighborhood'}
                                            {l s='Bairro' mod="brazilianfields"}
                                        {else}
                                            {$field.label}
                                        {/if}
                                    {/if}
                                </label>

                                <div class="col-md-6{if ($field.type === 'radio-buttons')} form-control-valign{/if}">
                                    {if $field.type === 'select'}
                                        <select class="form-control form-control-select" name="{$field.name}" {if $field.required}required{/if}>
                                            <option value disabled selected>{l s='-- please choose --' d='Shop.Forms.Labels'}</option>
                                            
                                            {foreach from=$field.availableValues item="label" key="value"}
                                                <option value="{$value}" {if $value eq $field.value} selected {/if}>{$label}</option>
                                            {/foreach}
                                        </select>
                                    {elseif $field.type === 'countrySelect'}
                                        <select class="form-control form-control-select js-country" name="{$field.name}"
                                            {if $field.required}required{/if}>
                                                <option value disabled selected>{l s='-- please choose --' d='Shop.Forms.Labels'}</option>
                                                
                                                {foreach from=$field.availableValues item="label" key="value"}
                                                    <option value="{$value}" {if $value eq $field.value} selected {/if}>{$label}</option>
                                                {/foreach}
                                        </select>
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
                                    {/if}
                                </div>
                            </div>
                                        {* {block name='form_field'}
                                            {form_field field=$field}
                                        {/block} *}
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