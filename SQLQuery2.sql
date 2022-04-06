/*
Cleaning Data in SQL Queries
*/

select*from portofolio_project..National_Housing

-- Standardize Date Format
select SaleDate , CONVERT(date,SaleDate)as date_convert
 from portofolio_project..National_Housing

Update National_Housing
SET SaleDate = CONVERT(Date,SaleDate)

-- If it doesn't Update properly

ALTER TABLE National_Housing
Add SaleDateConverted Date;

Update National_Housing
SET SaleDateConverted = CONVERT(Date,SaleDate)
 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data
select * from portofolio_project..National_Housing
--where PropertyAddress is null
order by ParcelID


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From portofolio_project..National_Housing a
JOIN portofolio_project..National_Housing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From portofolio_project..National_Housing a
JOIN portofolio_project..National_Housing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null
--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)
select PropertyAddress
from portofolio_project..National_Housing
--where PropertyAddress is null
--order by ParcelID

select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address
from portofolio_project..National_Housing

ALTER TABLE portofolio_project..National_Housing
Add PropertySplitAddress Nvarchar(255);

Update portofolio_project..National_Housing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE portofolio_project..National_Housing
Add PropertySplitCity Nvarchar(255);

Update portofolio_project..National_Housing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

select *
from portofolio_project..National_Housing



Select OwnerAddress,
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
from portofolio_project..National_Housing
where OwnerAddress is not null



ALTER TABLE portofolio_project..National_Housing
Add OwnerSplitAddress Nvarchar(255);

Update portofolio_project..National_Housing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE portofolio_project..National_Housing
Add OwnerSplitCity Nvarchar(255);

Update portofolio_project..National_Housing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE portofolio_project..National_Housing
Add OwnerSplitState Nvarchar(255);

Update portofolio_project..National_Housing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
from portofolio_project..National_Housing
Group by SoldAsVacant
order by 2

Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
from portofolio_project..National_Housing

Update portofolio_project..National_Housing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END


--WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

from portofolio_project..National_Housing
--)

ALTER TABLE portofolio_project..National_Housing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate










Select *
from portofolio_project..National_Housing


