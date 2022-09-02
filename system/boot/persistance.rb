Container.register_provider(:persistence) do |container|
  start do
    config = container['db.config']
    #config.auto_registration("#{container.root}/contexts/toy_testings")
    #config.auto_registration("#{container.root}/contexts/accounts")

    config.register_relation(ToyTestings::Relations::Tests)
    config.register_relation(ToyTestings::Relations::Toys)
    config.register_relation(ToyTestings::Relations::Accounts)

    register('rom_container', ROM.container(container['db.config']))
  end
end
