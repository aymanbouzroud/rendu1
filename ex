
import java.sql.*;
import java.util.Scanner;

public static void main(String[] args) {
     
        private static final String URL = "jdbc:mysql://localhost:3306/db";
        private static final String USER = "user";
        private static final String PASSWORD = "123";
    
    Connection connection = DriverManager.getConnection(url, user, password);
    System.out.println("Connexion ");
    Scanner scanner = new Scanner(System.in);
    int choix;
        System.out.println("1/ gestion des utilisateurs");
        System.out.println("2/ gestion des evenements");
        System.out.println("3/ gestion des salles");
        System.out.println("4/ gestion des terrains");
        System.out.println("5/ gestion des reservations");
        System.out.print("Choisissez option: ");
        choix = scanner.nextInt();
        switch (choix) {
            case 1:
             gestionUtilisateur(connection, scanner);
            break;
            case 2:
            gestionEvenement(connection, scanner);
            break;
            case 3:
            gestionSalle(connection, scanner);
            break;
            case 4:
            gestionTerrain(connection, scanner);
            break;
            case 5:
            gestionReservation(connection, scanner);
             break;
            default:
             System.out.println("Choix incorrect");
        }
}
static void gestionUtilisateur(Connection connection, Scanner scanner) {
    int choix; 
System.out.println("1/ ajouter un utilisateur");
System.out.println("2/ afficher les utilisateurs");
System.out.println("3/ suprimer un utilisateur");
 System.out.print("Choisissez  option: ");
choix = scanner.nextInt();
         switch (choix) {
            case 1:
             System.out.print("Nom: ");
            String nom = scanner.nextLine();
            System.out.print("Prenom: ");
            String prenom = scanner.nextLine();
            System.out.print("email: ");
            String email = scanner.nextLine();
            System.out.print("Type (ETUDIANT/PROFESSEUR): ");
            String type = scanner.nextLine();
            ajouterUtilisateur(connection, nom, prenom, email, type);
             break;
            case 2:
                afficherUtilisateur(connection);
                break;
            case 3:
                System.out.print("id l'utilisateur (supprimer): ");
                int idUser = scanner.nextInt();
                supprimerUtilisateur(connection, idUser);
                break;
            default:
                System.out.println("Choix incorrect ");
}}

static void ajouterUtilisateur(Connection connection, String nom, String prenom, String email, String type) {
    String sql = "INSERT INTO utilisateurs (nom, prenom, email, type) VALUES (?, ?, ?, ?)";
    PreparedStatement stmt = connection.prepareStatement(sql);
    stmt.setString(1, nom);
    stmt.setString(2, prenom);
    stmt.setString(3, email);
    stmt.setString(4, type);
    stmt.executeUpdate();
    System.out.println("Utilisateur ajoute ");
}

static void afficherUtilisateur(Connection connection) {
String sql = "SELECT * FROM utilisateurs";
Statement stmt = connection.createStatement();
ResultSet rs = stmt.executeQuery(sql);
 while (rs.next()) {
 System.out.println(rs.getInt("id_user") + ": " + rs.getString("nom") + " " + rs.getString("prenom"));
    }
}
static void supprimerUtilisateur(Connection connection, int id) {
    String sql = "DELETE FROM utilisateurs WHERE id_user = ?";
    PreparedStatement stmt = connection.prepareStatement(sql);
    stmt.setInt(1, id);
    stmt.executeUpdate();
    System.out.println("Utilisateur supprime ");
}


static void gestionEvenement(Connection connection, Scanner scanner) {
    int choix;

        System.out.println("1/ ajuter un evenement");
        System.out.println("2/ afficher les evenements");
        System.out.println("3/ modifier un evenement");
        System.out.println("4/ supprimer un evenement");
        System.out.print("Choisissez option: ");
        choix = scanner.nextInt();
 

        switch (choix) {
            case 1:
                System.out.print("Nom de l'evenement: ");
                String nomEvent = scanner.nextLine();
                System.out.print("Date de l'evenement : ");
                String dateEvent = scanner.nextLine();
                System.out.print("description: ");
                String description = scanner.nextLine();
                ajouterEvenement(connection, nomEvent, dateEvent, description);
                break;

            case 2:
                afficherEvenement(connection);
                break;

            case 3:
                System.out.print("id de l'evenement ( modifier): ");
                int idEvent = scanner.nextInt();
                scanner.nextLine(); 
                System.out.print("Nouveau nom de l'evenement: ");
                String nouveauNomEvent = scanner.nextLine();
                modifierEvenement(connection, idEvent, nouveauNomEvent);
                break;

            case 4:
                System.out.print("ID de l'evenement (supprimer): ");
                int idEventSupp = scanner.nextInt();
                supprimerEvenement(connection, idEventSupp);
                break;
            default:
                System.out.println("choix incorrect");
        }
    
}

static void ajouterEvenement(Connection connection, String nomEvent, String dateEvent, String description) {
    String sql = "INSERT INTO evenements (nom_event, date_event, description, id_user) VALUES (?, ?, ?, ?)";
    PreparedStatement stmt = connection.prepareStatement(sql);
    stmt.setString(1, nomEvent);
    stmt.setString(2, dateEvent);
    stmt.setString(3, description);
    stmt.setInt(4, 1); 
    stmt.executeUpdate();
    System.out.println("evenement ajoute");
}

static void afficherEvenement(Connection connection) {
    String sql = "SELECT * FROM evenements";
    Statement stmt = connection.createStatement();
    ResultSet rs = stmt.executeQuery(sql);
    while (rs.next()) {
        System.out.println(rs.getInt("id_event") + ": " + rs.getString("nom_event") + " le " + rs.getString("date_event"));
    }
}

static void modifierEvenement(Connection connection, int id, String nouveauNomEvent) {
    String sql = "UPDATE evenements SET nom_event = ? WHERE id_event = ?";
    PreparedStatement stmt = connection.prepareStatement(sql);
    stmt.setString(1, nouveauNomEvent);
    stmt.setInt(2, id);
    stmt.executeUpdate();
    System.out.println("evenement modifie ");
}

static void supprimerEvenement(Connection connection, int id) {
    String sql = "DELETE FROM evenements WHERE id_event = ?";
    PreparedStatement stmt = connection.prepareStatement(sql);
    stmt.setInt(1, id);
    stmt.executeUpdate();
    System.out.println("evenement supprime ");
}


static void gestionSalle(Connection connection, Scanner scanner) {
    int choix;
    System.out.println("1/ Ajouter une salle");
    System.out.println("2/ Afficher les salles");
    System.out.println("3/ Supprimer une salle");
     System.out.print("Choisissez option: ");
        choix = scanner.nextInt();
        switch (choix) {
         case 1:
                System.out.print("Nom de la salle: ");
                String nomSalle = scanner.nextLine();
                System.out.print("Capacite: ");
                int capacite = scanner.nextInt();
                ajouterSalle(connection, nomSalle, capacite);
                break;

        case 2:
                afficherSalle(connection);
                break;

         case 3:
                System.out.print("ID de la salle ( supprimer) :");
                int idSalle = scanner.nextInt();
                supprimerSalle(connection, idSalle);
                break;
         default:
                System.out.println("Choix  incorrect");
        }
}

static void ajouterSalle(Connection connection, String nomSalle, int capacite) {
    String sql = "INSERT INTO salles (nom_salle, capacite) VALUES (?, ?)";
    PreparedStatement stmt = connection.prepareStatement(sql);
    stmt.setString(1, nomSalle);
    stmt.setInt(2, capacite);
    stmt.executeUpdate();
    System.out.println("salle ajoute ");
}

static void afficherSalle(Connection connection) {
    String sql = "SELECT * FROM salles";
    Statement stmt = connection.createStatement();
    ResultSet rs = stmt.executeQuery(sql);
    while (rs.next()) {
        System.out.println(rs.getInt("id_salle") + ": " + rs.getString("nom_salle") + " (Capacité: " + rs.getInt("capacite") + ")");
    }
}

static void supprimerSalle(Connection connection, int id) {
    String sql = "DELETE FROM salles WHERE id_salle = ?";
    PreparedStatement stmt = connection.prepareStatement(sql);
    stmt.setInt(1, id);
    stmt.executeUpdate();
    System.out.println("salle supprime ");
}

static void gestionTerrain(Connection connection, Scanner scanner) {
    int choix;
        System.out.println("1/Ajouter un terrain");
        System.out.println("2/Afficher les terrains");
        System.out.println("3/ Supprimer un terrain");
        System.out.print("Choisissez option: ");
        choix = scanner.nextInt();
    
        switch (choix) {
            case 1:
                System.out.print("nom du terrain: ");
                String nomTerrain = scanner.nextLine();
                System.out.print("type de terrain: ");
                String typeTerrain = scanner.nextLine();
                ajouterTerrain(connection, nomTerrain, typeTerrain);
                break;

            case 2:
                afficherTerrain(connection);
                break;

            case 3:
                System.out.print("id terrain (supprime): ");
                int idTerrain = scanner.nextInt();
                supprimerTerrain(connection, idTerrain);
                break;

            default:
                System.out.println("Choix incorrect");
        }
}

static void ajouterTerrain(Connection connection, String nomTerrain, String typeTerrain) {
    String sql = "INSERT INTO terrains (nom_terrain, type) VALUES (?, ?)";
    PreparedStatement stmt = connection.prepareStatement(sql);
    stmt.setString(1, nomTerrain);
    stmt.setString(2, typeTerrain);
    stmt.executeUpdate();
    System.out.println("terrain ajoute ");
}

static void afficherTerrain(Connection connection) {
    String sql = "SELECT * FROM terrains";
    Statement stmt = connection.createStatement();
    ResultSet rs = stmt.executeQuery(sql);
    while (rs.next()) {
        System.out.println(rs.getInt("id_terrain") + " " + rs.getString("nom_terrain") + " (Type: " + rs.getString("type") + ")");
    }
}

static void supprimerTerrain(Connection connection, int id) {
    String sql = "DELETE FROM terrains WHERE id_terrain = ?";
    PreparedStatement stmt = connection.prepareStatement(sql);
    stmt.setInt(1, id);
    stmt.executeUpdate();
    System.out.println("terrain supprime ");
}

static void gestionReservation(Connection connection, Scanner scanner) {
    int choix;
        System.out.println("1/ reserver");
        System.out.println("2. afficher les reservations");
        System.out.println("3. modifier une reservation");
        System.out.println("4. supprimer une reservation");
        System.out.print("Choisissez option: ");
        choix = scanner.nextInt();
        scanner.nextLine(); 
        switch (choix) {
         case 1:
        reserver(connection, scanner);
         break;
            case 2:
        afficherReservations(connection);
        break;
         case 3:
         System.out.print("id de la reservation (modifier) : ");
        int idReservation = scanner.nextInt();
        scanner.nextLine(); 
        System.out.print("Nouvelle date de reservation (YYYY-MM-DD): ");
        String nouvelleDate = scanner.nextLine();
        modifierReservation(connection, idReservation, nouvelleDate);
        break;

        case 4:
         System.out.print("id de la reservation (suprimer): ");
        int idReservationSupp = scanner.nextInt();
        supprimerReservation(connection, idReservationSupp);
        break;
        default:
        System.out.println("Choix incorrect ");
        }
}

static void reserver(Connection connection, Scanner scanner) {
    System.out.print("id utilisateur: ");
    int idUser = scanner.nextInt();
    System.out.print("id evenement: ");
    int idEvent = scanner.nextInt();
    System.out.print("id salle: ");
    int idSalle = scanner.nextInt();
    System.out.print("id terrain: ");
    int idTerrain = scanner.nextInt();
    System.out.print("date de reservation : ");
    String dateReservation = scanner.next();

    String sql = "INSERT INTO reservations (id_user, id_event, id_salle, id_terrain, date_reservation) VALUES (?, ?, ?, ?, ?)";
    PreparedStatement stmt = connection.prepareStatement(sql);
    stmt.setInt(1, idUser);
    stmt.setInt(2, idEvent);
    stmt.setInt(3, idSalle);
    stmt.setInt(4, idTerrain);
    stmt.setString(5, dateReservation);
    stmt.executeUpdate();
    System.out.println("reservation ajoute");
}

static void afficherReservations(Connection connection) {
    String sql = "SELECT * FROM reservations";
    Statement stmt = connection.createStatement();
    ResultSet rs = stmt.executeQuery(sql);
    while (rs.next()) {
        System.out.println(rs.getInt("id_reservation") + ": utilisateur " + rs.getInt("id_user") + " a réservé l'événement " + rs.getInt("id_event"));
    }
}

static void modifierReservation(Connection connection, int id, String nouvelleDate) {
    String sql = "UPDATE reservations SET date_reservation = ? WHERE id_reservation = ?";
    PreparedStatement stmt = connection.prepareStatement(sql);
    stmt.setString(1, nouvelleDate);
    stmt.setInt(2, id);
    stmt.executeUpdate();
    System.out.println("reservation modifie ");
}

static void supprimerReservation(Connection connection, int id) {
    String sql = "DELETE FROM reservations WHERE id_reservation = ?";
    PreparedStatement stmt = connection.prepareStatement(sql);
    stmt.setInt(1, id);
    stmt.executeUpdate();
    System.out.println("reservation supprime ");
}
}
