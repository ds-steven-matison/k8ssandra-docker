<h1>Yay, our K8ssandra Docker Application works!!!</h1>

<h2>What are the credentials we need to access Stargate & Cassandra?</h2>
<ul>
<li>GraphQL API: <?php print_r($_SERVER[GRAPHQL_URL]); ?></li>
<li>Rest API: <?php print_r($_SERVER[STARGATE_URL]); ?></li>
<li>Auth Token API: <?php print_r($_SERVER[K8S_AUTH_URL]); ?></li>
<li>Username: <?php print_r($_SERVER[K8S_PASSWORD]); ?></li>
<li>Password: <?php print_r($_SERVER[K8S_USERNAME]); ?></li>
</ul>