{extends file='customer/page.tpl'}

{block name='page_title'}
    {if $editing}
        {l s='Update your address' d='Shop.Theme.Customeraccount'}
    {else}
        {l s='New address' d='Shop.Theme.Customeraccount'}
    {/if}
{/block}

{block name='page_content'}
    <pre>
        {$formFields|@print_r}
    </pre>

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
                            {block name='form_field'}
                                {form_field field=$field}
                            {/block}
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