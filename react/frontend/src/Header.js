import "./Header.css";

import { Grid } from "@sanity/ui";
import { Link } from "react-router-dom";

const HeaderLink = ({ page }) => {
  const title = page.charAt(0).toUpperCase() + page.slice(1);
  return (
    <Link to={`/${page}`} className="headerlink-title">
      {title}
    </Link>
  );
};

const Header = () => {
  return (
    <div className="header">
      <Grid
        columns={[2]}
        gap={[0]}
        style={{ width: "210px", maxWidth: "420px", textAlign: "left" }}
      >
        <HeaderLink page="om"></HeaderLink>
        {/*<HeaderLink page="uppladdning"></HeaderLink>*/}
        <HeaderLink page="uppladdning"></HeaderLink>
        {/*<HeaderLink page="kontakt"></HeaderLink>*/}
      </Grid>
    </div>
  );
};

export default Header;
